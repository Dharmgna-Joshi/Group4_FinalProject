<%@ Page Title="Admin" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Admin.aspx.cs" Inherits="Group4_FinalProject.Admin" %>

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

        .edit-button, .delete-button {
            padding: 5px 10px;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .edit-button { background-color: #28a745; } /* Green */
        .delete-button { background-color: #dc3545; } /* Red */

        .grid-view-table {
            width: 100%;
            border-collapse: collapse;
        }

        .grid-view-table th, .grid-view-table td {
            border: 1px solid #dee2e6; /* Light grey border */
            padding: 8px;
            text-align: left;
        }

        .grid-view-table th {
            background-color: #f8f9fa; /* Light background on headers */
        }

        .grid-view-table tr:hover {
            background-color: #f1f1f1;
        }

        .dropdown-wide {
            width: 100%; /* Full width of the container */
        }
    </style>

    <h2>Category Management</h2>
    <asp:GridView ID="GridViewCategory" runat="server" AutoGenerateColumns="False" DataKeyNames="CategoryID"
        CssClass="grid-view-table"
        OnRowEditing="GridViewCategory_RowEditing" OnRowDeleting="GridViewCategory_RowDeleting"
        OnRowUpdating="GridViewCategory_RowUpdating" OnRowCancelingEdit="GridViewCategory_RowCancelingEdit">
        <Columns>
            <asp:BoundField DataField="CategoryID" HeaderText="Category ID" ReadOnly="True" />
            <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:CommandField ShowEditButton="True" ButtonType="Link" EditText="Edit" ControlStyle-CssClass="edit-button" />
            <asp:CommandField ShowDeleteButton="True" ButtonType="Link" DeleteText="Delete" ControlStyle-CssClass="delete-button" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server"
        ConnectionString="<%$ ConnectionStrings:ElectronicsConnectionString %>"
        SelectCommand="SELECT * FROM Categories"
        UpdateCommand="UPDATE Categories SET CategoryName=@CategoryName, Description=@Description WHERE CategoryID=@CategoryID"
        DeleteCommand="DELETE FROM Categories WHERE CategoryID=@CategoryID">
        <UpdateParameters>
            <asp:Parameter Name="CategoryName" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="CategoryID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="CategoryID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <!-- Dropdown for selecting categories -->
    <h2>Select Category to View Products</h2>
    <asp:DropDownList ID="ddlCategories" runat="server" CssClass="dropdown-wide" AutoPostBack="true" OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged">
    </asp:DropDownList>

    <!-- GridView for Products -->
    <h2>Product Management</h2>
    <asp:GridView ID="GridViewProducts" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID"
        CssClass="grid-view-table"
        OnRowEditing="GridViewProducts_RowEditing" OnRowDeleting="GridViewProducts_RowDeleting"
        OnRowUpdating="GridViewProducts_RowUpdating" OnRowCancelingEdit="GridViewProducts_RowCancelingEdit">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="Product ID" ReadOnly="True" />
            <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:CommandField ShowEditButton="True" ButtonType="Link" EditText="Edit" ControlStyle-CssClass="edit-button" />
            <asp:CommandField ShowDeleteButton="True" ButtonType="Link" DeleteText="Delete" ControlStyle-CssClass="delete-button" />
        </Columns>
    </asp:GridView>

    <!-- SqlDataSource for Products GridView -->
    <asp:SqlDataSource ID="SqlDataSourceProducts" runat="server"
        ConnectionString="<%$ ConnectionStrings:ElectronicsConnectionString %>"
        SelectCommand="SELECT * FROM Products WHERE CategoryID=@CategoryID"
        UpdateCommand="UPDATE Products SET ProductName=@ProductName, Description=@Description WHERE ProductID=@ProductID"
        DeleteCommand="DELETE FROM Products WHERE ProductID=@ProductID">
        <SelectParameters>
            <asp:ControlParameter Name="CategoryID" Type="Int32" ControlID="ddlCategories" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
