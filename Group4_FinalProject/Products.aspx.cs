using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
namespace Group4_FinalProject
{
    public partial class Products : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateProductsDropdown();
            }
        }
        private void PopulateProductsDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT ProductID, ProductName FROM Products", con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlProducts.DataSource = reader;
                ddlProducts.DataValueField = "ProductID";
                ddlProducts.DataTextField = "ProductName";
                ddlProducts.DataBind();

                reader.Close();
                con.Close();

                ddlProducts.Items.Insert(0, new ListItem("Select a product", ""));
            }
        }

        protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT Description, Price, ImageUrl FROM Products WHERE ProductID = @ProductID", con);
                cmd.Parameters.AddWithValue("@ProductID", ddlProducts.SelectedValue);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblDescription.Text = "Description: " + reader["Description"].ToString();
                    lblPrice.Text = "Price: $" + reader["Price"].ToString();
                    imgProduct.ImageUrl = reader["ImageUrl"].ToString(); // Assuming the column name is 'ImageUrl'
                }
                else
                {
                    lblDescription.Text = "Description: Not found.";
                    lblPrice.Text = "Price: Not found.";
                    imgProduct.ImageUrl = ""; 
                }

                reader.Close();
                con.Close();
            }
        }

    }
}