using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Group4_FinalProject
{
    public partial class Cart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCartData();
            }
            
        }
        private void BindCartData()
        {
            DataTable cart = Session["Cart"] as DataTable;
            if (cart != null)
            {
                // Convert the cart into a display-friendly DataTable
                DataTable displayCart = new DataTable();
                displayCart.Columns.Add("ProductName");
                displayCart.Columns.Add("Price", typeof(decimal));
                displayCart.Columns.Add("Quantity", typeof(int));
                displayCart.Columns.Add("Total", typeof(decimal));

                foreach (DataRow row in cart.Rows)
                {
                    // Retrieve product details based on ProductID
                    int productId = (int)row["ProductID"];
                    int quantity = (int)row["Quantity"];

                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString))
                    {
                        SqlCommand cmd = new SqlCommand("SELECT ProductName, Price FROM Products WHERE ProductID = @ProductID", con);
                        cmd.Parameters.AddWithValue("@ProductID", productId);
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                DataRow displayRow = displayCart.NewRow();
                                displayRow["ProductName"] = reader["ProductName"];
                                decimal price = (decimal)reader["Price"];
                                displayRow["Price"] = price;
                                displayRow["Quantity"] = quantity;
                                displayRow["Total"] = price * quantity;
                                displayCart.Rows.Add(displayRow);
                            }
                        }
                    }
                }

                gvCart.DataSource = displayCart;
                gvCart.DataBind();
            }
        }
        protected void EmptyCart(object sender, EventArgs e)
        {
            // Clear the cart in the session directly
            Session["Cart"] = null;

            // Bind an empty DataTable to the GridView
            gvCart.DataSource = new DataTable();
            gvCart.DataBind();

            // Optionally, show a message or hide the cart table
            gvCart.Visible = false;
            lblCartEmptyMessage.Visible = true; // Make sure you have a Label control with ID lblCartEmptyMessage in your .aspx page
        }
        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                // Retrieve the row index stored in the CommandArgument property.
                int index = Convert.ToInt32(e.CommandArgument);

                // Retrieve the cart from the session.
                DataTable cart = Session["Cart"] as DataTable;

                if (cart != null && index < cart.Rows.Count)
                {
                    // Remove the row from the cart DataTable.
                    cart.Rows.RemoveAt(index);

                    // Update the session.
                    Session["Cart"] = cart;

                    // Rebind the GridView to reflect the changes.
                    BindCartData();
                }
            }
        }
       

    }
}