using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group4_FinalProject
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Validate additional fields before processing the order
                if (string.IsNullOrWhiteSpace(txtFirstName.Text))
                {
                    // Display error message for missing first name
                    Response.Write("<script>alert('First Name is required.');</script>");
                    return;
                }

                // Validate other fields as needed

                // Implement your logic to process the order here
                // For example, save order details to the database

                // Clear the cart session after placing the order
                Session["Cart"] = null;

                // Optionally, redirect to a confirmation page or display a success message
                Response.Write("<script>alert('Order Placed Successfully.');</script>");

                // Clear the form fields
                txtEmail.Text = string.Empty;
                txtAddress.Text = string.Empty;
                // Clear other form fields as necessary
            }

        }
    }
}