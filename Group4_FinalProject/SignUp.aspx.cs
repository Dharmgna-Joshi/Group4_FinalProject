using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace Group4_FinalProject
{
    public partial class Signup : Page
    {
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;
            string role = ddlRole.SelectedValue;
            Response.Write("Selected Role: " + role);

            string passwordHash = ComputeSha256Hash(password);

            string connectionString = WebConfigurationManager.ConnectionStrings["ElectronicsConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Users (Username, PasswordHash, Role) VALUES (@Username, @PasswordHash, @Role)", conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                cmd.Parameters.AddWithValue("@Role", role);

                try
                {
                    conn.Open();
                    int result = cmd.ExecuteNonQuery();
                    if (result > 0)
                    {
                        lblStatus.Text = "Signup successful.";
                        Session["UserRole"] = role;
                        Response.Redirect("~/Login.aspx");
                    }
                    else
                    {
                        lblStatus.Text = "Signup failed. Please try again.";
                    }
                }
                catch (SqlException ex)
                {
                    // Handle SQL exceptions
                    lblStatus.Text = "Database error occurred: " + ex.Message;
                }
                catch (Exception ex)
                {
                    // Handle other exceptions
                    lblStatus.Text = "An error occurred: " + ex.Message;
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
