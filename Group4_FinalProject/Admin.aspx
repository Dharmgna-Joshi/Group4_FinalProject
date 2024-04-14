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

        .edit-button {
            color: #fff;
            background-color: #28a745; /* Bootstrap green */
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
            margin-right: 5px;
        }

        .delete-button {
            color: #fff;
            background-color: #dc3545; /* Bootstrap red */
            padding: 5px 10px;
            border-radius: 4px;
            text-decoration: none;
        }

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

            /* Hover effect for rows */
            .grid-view-table tr:hover {
                background-color: #f1f1f1;
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
        <RowStyle BackColor="#f9f9f9" />
        <AlternatingRowStyle BackColor="#fcfcfc" />
        <HeaderStyle BackColor="#e9ecef" Font-Bold="True" />
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



</asp:Content>
