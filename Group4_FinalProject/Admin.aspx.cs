using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace Group4_FinalProject
{
    public partial class Admin : System.Web.UI.Page
    {
        // Connection string to connect to the database
        private string connectionString = WebConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCategoryGridView(); // Load the categories on initial page load
                PopulateCategoriesDropDown();
            }
        }

        private void BindCategoryGridView()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Categories", con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    sda.Fill(ds);
                    GridViewCategory.DataSource = ds;
                    GridViewCategory.DataBind();
                }
                catch (Exception ex)
                {
                    // Handle the error
                    Response.Write("Error: " + ex.Message);
                }
            }
        }

        protected void GridViewCategory_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewCategory.EditIndex = e.NewEditIndex;
            BindCategoryGridView(); // Refresh the GridView
        }

        protected void GridViewCategory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewCategory.EditIndex = -1;
            BindCategoryGridView(); // Cancel edit mode and refresh the GridView
        }

        protected void GridViewCategory_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Retrieve updated data from GridView
            GridViewRow row = GridViewCategory.Rows[e.RowIndex];
            int categoryId = Convert.ToInt32(GridViewCategory.DataKeys[e.RowIndex].Values["CategoryID"]);

            // Access the TextBox controls by index
            // The index might change depending on the position of the controls in the Controls collection
            TextBox txtCategoryName = row.Cells[1].Controls[0] as TextBox;
            TextBox txtDescription = row.Cells[2].Controls[0] as TextBox;

            string categoryName = txtCategoryName.Text;
            string description = txtDescription.Text;

            // Update the category in the database
            UpdateCategory(categoryId, categoryName, description);

            GridViewCategory.EditIndex = -1;
            BindCategoryGridView(); // Exit edit mode and refresh the GridView
        }


        private void UpdateCategory(int categoryId, string categoryName, string description)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Categories SET CategoryName = @CategoryName, Description = @Description WHERE CategoryID = @CategoryID", con);
                cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                cmd.Parameters.AddWithValue("@Description", description);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // Handle the error
                    Response.Write("Error: " + ex.Message);
                }
            }
        }

        protected void GridViewCategory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Retrieve the CategoryID to delete
            int categoryId = Convert.ToInt32(GridViewCategory.DataKeys[e.RowIndex].Values["CategoryID"]);

            // Delete the category from the database
            DeleteCategory(categoryId);

            BindCategoryGridView(); // Refresh the GridView
        }

        private void DeleteCategory(int categoryId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Categories WHERE CategoryID = @CategoryID", con);
                cmd.Parameters.AddWithValue("@CategoryID", categoryId);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // Handle the error
                    Response.Write("Error: " + ex.Message);
                }
            }
        }
        private void PopulateCategoriesDropDown()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT CategoryID, CategoryName FROM Categories", conn);
                try
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "Categories");
                    ddlCategories.DataSource = ds.Tables["Categories"];
                    ddlCategories.DataTextField = "CategoryName";
                    ddlCategories.DataValueField = "CategoryID";
                    ddlCategories.DataBind();

                    ddlCategories.Items.Insert(0, new ListItem("-- Select Category --", ""));
                }
                catch (Exception ex)
                {
                    // Handle exceptions
                }
            }
        }
        protected void ddlCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewProducts.DataSourceID = "SqlDataSourceProducts";
            GridViewProducts.DataBind();
        }

        protected void GridViewProducts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewProducts.EditIndex = e.NewEditIndex;
            GridViewProducts.DataBind();
        }

        protected void GridViewProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Retrieve row from the grid
            GridViewRow row = GridViewProducts.Rows[e.RowIndex];
            string productName = ((TextBox)row.Cells[1].Controls[0]).Text;
            string description = ((TextBox)row.Cells[2].Controls[0]).Text;
            int productId = Convert.ToInt32(GridViewProducts.DataKeys[e.RowIndex].Value);

            // Perform the update operation
            UpdateProduct(productId, productName, description);

            // Reset the edit index and refresh the grid
            GridViewProducts.EditIndex = -1;
            GridViewProducts.DataBind();
        }

        private void UpdateProduct(int productId, string productName, string description)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Products SET ProductName=@ProductName, Description=@Description WHERE ProductID=@ProductID", conn);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // Handle exceptions
                }
            }
        }

        protected void GridViewProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int productId = Convert.ToInt32(GridViewProducts.DataKeys[e.RowIndex].Value);
            DeleteProduct(productId);
            GridViewProducts.DataBind();
        }

        private void DeleteProduct(int productId)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Products WHERE ProductID=@ProductID", conn);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    // Handle exceptions
                }
            }
        }

        protected void GridViewProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewProducts.EditIndex = -1;
            GridViewProducts.DataBind();
        }
    }
}
