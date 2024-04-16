using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using static System.Collections.Specialized.BitVector32;
using System.Web.UI;
using System.Web;

namespace Group4_FinalProject
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetNoStore();

                if (Session["Username"] != null)
                {
                    string username = Session["Username"].ToString();
                    string userRole = GetUserRole(username); // Retrieve user role from database

                    AdjustNavigationLinks(userRole); // Adjust navigation links based on user role
                    lblWelcome.Text = "Welcome, " + username;
                }
                else
                {
                    // User is not logged in, show only signup and login links
                    ShowLoginLinks();
                }
            }
        }

        // Method to retrieve user role from the database
        private string GetUserRole(string username)
        {
            string userRole = ""; // Default role

            // Query the database to fetch user role based on username
            string connectionString = WebConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT Role FROM Users WHERE Username = @Username", con);
                cmd.Parameters.AddWithValue("@Username", username);

                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    userRole = result.ToString();
                }
            }

            return userRole;
        }

        // Method to adjust navigation links based on user role
        private void AdjustNavigationLinks(string userRole)
        {
            switch (userRole)
            {
                case "Admin":
                    lnkHome.Visible = true;
                    lnkAdmin.Visible = true;
                    lnkProducts.Visible = false;
                    lnkCart.Visible = false;
                    lnkSignUp.Visible = false;
                    lnkLogin.Visible = false;
                    lnkLogout.Visible = true;
                    break;
                case "Customer":
                    lnkHome.Visible = true;
                    lnkAdmin.Visible = false;
                    lnkProducts.Visible = true;
                    lnkCart.Visible = true;
                    lnkSignUp.Visible = false;
                    lnkLogin.Visible = false;
                    lnkLogout.Visible = true;
                    break;
                default:
                    // Handle any other roles or unexpected cases
                    ShowLoginLinks(); // Fallback to showing login links
                    break;
            }
        }

        // Method to show only signup and login links
        private void ShowLoginLinks()
        {
            lnkHome.Visible = false;
            lnkAdmin.Visible = false;
            lnkProducts.Visible = false;
            lnkCart.Visible = false;
            lnkSignUp.Visible = true;
            lnkLogin.Visible = true;
            lnkLogout.Visible = false;
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }
    }
}
