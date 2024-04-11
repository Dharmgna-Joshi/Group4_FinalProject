<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="Group4_FinalProject.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .boldLabel {
            font-weight: bold;
        }
        .product-image {
            max-width: 100%;
            height: auto;
        }
        .product-info-container {
            display: flex;
            justify-content: space-between;
        }
        .product-details {
            flex: 1;
        }
    </style>
    <h2>Products</h2>

    <div class="product-info-container">
        <!-- Container for selecting the product -->
        <div class="product-details">
            <!-- Dropdown for selecting the product -->
            <asp:DropDownList ID="ddlProducts" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged">
                <asp:ListItem Text="Select a product" Value="" />
            </asp:DropDownList>

            <!-- Container for displaying the product info -->
            <div>
                <h3>Product Information:</h3>
                <asp:Label ID="lblDescription" runat="server" Text="Description: " CssClass="boldLabel"></asp:Label>
                <br />
                <asp:Label ID="lblPrice" runat="server" Text="Price: " CssClass="boldLabel"></asp:Label>
                  <br />
                <!-- Text field for entering product quantity -->
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="quantity-field" TextMode="Number" Min="1" />
                <asp:Label ID="lblQuantity" runat="server" Text="Quantity: " AssociatedControlID="txtQuantity"></asp:Label>
                </div>
        </div>
        
        <!-- Container for displaying the product image -->
        <div>
            <asp:Image ID="imgProduct" runat="server" CssClass="product-image" />
        </div>

    </div>
</asp:Content>
