using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Linq;
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
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Assuming productID is the unique identifier for products
            int productId = int.Parse(ddlProducts.SelectedValue);
            int quantity = int.Parse(txtQuantity.Text);

            // Retrieve the current cart from the session (or create a new one)
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null)
            {
                cart = new DataTable();
                cart.Columns.Add("ProductID", typeof(int));
                cart.Columns.Add("Quantity", typeof(int));

                Session["Cart"] = cart;
            }

            // Check if the product is already in the cart
            DataRow existingRow = cart.AsEnumerable().FirstOrDefault(row => (int)row["ProductID"] == productId);
            if (existingRow != null)
            {
                // Update quantity if the item is already in the cart
                existingRow["Quantity"] = (int)existingRow["Quantity"] + quantity;
            }
            else
            {
                // Add the new item to the cart
                DataRow newRow = cart.NewRow();
                newRow["ProductID"] = productId;
                newRow["Quantity"] = quantity;
                cart.Rows.Add(newRow);
            }

            // Update the session with the new cart
            Session["Cart"] = cart;
        }
        protected void btnGoToCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Cart.aspx");
        }



    }
}