<%@ Page Title="Signup" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="Group4_FinalProject.Signup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    </style>

    <h2>Signup</h2>
    <div class="form-container">
        <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidatorUsername" runat="server"
            ControlToValidate="txtUsername" ErrorMessage="Username is required"
            ForeColor="Red">*</asp:RequiredFieldValidator>

        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server"
            ControlToValidate="txtPassword" ErrorMessage="Password is required"
            ForeColor="Red">*</asp:RequiredFieldValidator>

        <asp:Label ID="lblRole" runat="server" Text="Role:"></asp:Label>
        <asp:DropDownList ID="ddlRole" runat="server">
            <asp:ListItem Text="Select Role" Value=""></asp:ListItem>
            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
            <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidatorRole" runat="server"
            ControlToValidate="ddlRole" InitialValue="" ErrorMessage="Select a role"
            ForeColor="Red">*</asp:RequiredFieldValidator>
        <asp:Label ID="lblStatus" runat="server" CssClass="text-danger"></asp:Label>

        <asp:Button ID="btnSignup" runat="server" Text="Signup" OnClick="btnSignup_Click" />
    </div>
</asp:Content>
