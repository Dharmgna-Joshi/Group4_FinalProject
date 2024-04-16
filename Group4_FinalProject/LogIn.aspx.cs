using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace Group4_FinalProject
{
    public partial class Login : Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            // Hash the password before comparing it with the database
            string passwordHash = ComputeSha256Hash(password);

            string connectionString = WebConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT UserID,Role FROM Users WHERE Username = @Username AND PasswordHash = @PasswordHash", conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);

                conn.Open();
                object result = cmd.ExecuteScalar();
                object roleObj = cmd.ExecuteScalar();
                string role = roleObj.ToString();
                if (result != null)
                {
                    // Successful login
                    lblMessage.Text = "Login successful!";
                    Session["UserRole"] = role;
                    Session["Username"] = username;
                    
                    // Redirect to another page or set the user session, etc.
                    Response.Redirect("~/");
                }
                else
                {
                    // Login failed
                    lblMessage.Text = "Invalid username or password.";
                }
            }
        }

        private static string ComputeSha256Hash(string rawData)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
