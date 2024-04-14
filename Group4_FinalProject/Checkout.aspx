<%@ Page Title="Checkout Page" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Checkout.aspx.cs" Inherits="Group4_FinalProject.Checkout" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
        }

        h2 {
            color: #3498db;
        }

        .form-section {
            margin-bottom: 15px;
        }

        .form-section label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .form-section input[type="text"],
        .form-section input[type="email"],
        .form-section input[type="password"],
        .form-section select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }

        .form-actions {
            text-align: center;
            margin-top: 15px;
        }

        .btn {
            background-color: #3498db;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .text-danger {
            color: #e74c3c;
        }
    </style>

    <div class="form-container">
        <h2>Check Out Page</h2>

        <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Please correct these errors:" CssClass="text-danger" />

        <div class="contact-information form-section">
            <h3>Contact Information</h3>
            <label for="txtEmail">Email Address:</label>
            <asp:TextBox ID="txtEmail" runat="server" />
            <asp:RegularExpressionValidator ID="RegexValidatorEmail" runat="server"
                ControlToValidate="txtEmail" ErrorMessage="Must be a valid email address"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                Display="Dynamic" CssClass="text-danger" />

            <label for="txtEmail2">Email Re-entry:</label>
            <asp:TextBox ID="txtEmail2" runat="server" />
            <asp:CompareValidator ID="CompareValidatorEmail" runat="server"
                ControlToValidate="txtEmail2" ControlToCompare="txtEmail"
                ErrorMessage="Email must match first email address"
                Display="Dynamic" CssClass="text-danger" />

            <label for="txtFirstName">First Name:</label>
            <asp:TextBox ID="txtFirstName" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName" runat="server"
                ControlToValidate="txtFirstName" ErrorMessage="First Name is required"
                Display="Dynamic" CssClass="text-danger" />

            <!-- Additional fields for Last Name, and Phone Number with respective validators -->
            <label for="txtLastName">Last Name:</label>
            <asp:TextBox ID="txtLastName" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorLastName" runat="server"
                ControlToValidate="txtLastName" ErrorMessage="Last Name is required"
                Display="Dynamic" CssClass="text-danger" />

            <label for="txtPhone">Phone Number:</label>
            <asp:TextBox ID="txtPhone" runat="server" />
            <asp:RegularExpressionValidator ID="RegexValidatorPhone" runat="server"
                ControlToValidate="txtPhone" ErrorMessage="Invalid phone number"
                ValidationExpression="\d{10}"
                Display="Dynamic" CssClass="text-danger" />

            <!-- Add a Calendar control for Date of Birth if required -->
        </div>

        <div class="billing-address form-section">
            <h3>Billing Address</h3>
            <label for="txtAddress">Address:</label>
            <asp:TextBox ID="txtAddress" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorAddress" runat="server"
                ControlToValidate="txtAddress" ErrorMessage="Address is required"
                Display="Dynamic" CssClass="text-danger" />

            <!-- Additional fields for City, State dropdown, and Zip Code with respective validators -->
            <label for="txtCity">City:</label>
            <asp:TextBox ID="txtCity" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorCity" runat="server"
                ControlToValidate="txtCity" ErrorMessage="City is required"
                Display="Dynamic" CssClass="text-danger" />

            <label for="ddlState">State:</label>
            <asp:DropDownList ID="ddlState" runat="server">
                <asp:ListItem Text="--Select--" Value="" />
                <asp:ListItem Text="New York" Value="NY" />
                <asp:ListItem Text="California" Value="CA" />
                <asp:ListItem Text="Texas" Value="TX" />
                <asp:ListItem Text="Florida" Value="FL" />
                <asp:ListItem Text="Illinois" Value="IL" />
            </asp:DropDownList>

            <asp:RequiredFieldValidator ID="RequiredFieldValidatorState" runat="server"
                ControlToValidate="ddlState" ErrorMessage="State is required"
                InitialValue="--Select--"
                Display="Dynamic" CssClass="text-danger" />

            <label for="txtZip">Zip code:</label>
            <asp:TextBox ID="txtZip" runat="server" />
        </div>

        <div class="form-actions">
            <asp:Button ID="btnBackToCart" runat="server" Text="Go back to Cart" PostBackUrl="~/Cart.aspx" CssClass="btn" />
            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" OnClick="btnPlaceOrder_Click" CssClass="btn" />
        </div>
    </div>
</asp:Content>
