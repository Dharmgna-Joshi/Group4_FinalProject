<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="Group4_FinalProject.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* General styling for bold labels */
        .boldLabel {
            font-weight: bold;
            color: #333;
        }
         .asp-dropdown {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            color: #333;
            background-color: white;
            cursor: pointer;
            width: auto;
            display: block; /* Ensure it takes the full width */
        }

        /* Styling for product images */
        .product-image {
            width: 600px; /* Fixed width */
            height: 510px; /* Fixed height */
        }

        /* Container styling for product info and image */
        .product-info-container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            background-color: #f8f9fa;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Styling for product details section */
        .product-details {
            flex: 1;
            margin-right: 20px;
        }

        /* Input fields styling */
        .quantity-field {
            width: 100px;
            padding: 5px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
 /* Updated button styling with new color and curvature */
        .buttons .asp-Button {
            padding: 10px 15px;
            border: none;
            background-color: #28a745; /* New button color: green */
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 10px; /* Rounded corners for the buttons */
            margin-right: 10px;
            transition: background-color 0.3s;
            padding:10px;
            margin-top: 10px;
        }
        .buttons .asp-Button:hover {
            background-color: #218838; /* Darker green on hover */
        }

        /* Product information heading */
        h3 {
            color: #333;
            font-size: 18px;
            margin-bottom: 10px;
        }
    </style>

    <h2>Products</h2>
    <div>
        <asp:Label ID="lblUsername" runat="server" CssClass="boldLabel"></asp:Label>
    </div>
    <div class="product-info-container">
        <!-- Container for selecting the product -->
        <div class="product-details">
            <!-- Dropdown for selecting the product -->
            <asp:DropDownList ID="ddlProducts" CssClass="asp-dropdown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged">
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
                <div class="buttons">
                    <asp:Button ID="btnAddToCart" runat="server" CssClass="asp-Button" Text="Add to Cart" OnClick="btnAddToCart_Click" />
<asp:Button ID="btnGoToCart" runat="server" CssClass="asp-Button" Text="Go to Cart" OnClick="btnGoToCart_Click" />

                </div>
            </div>
        </div>
        
        <!-- Container for displaying the product image -->
        <div>
            <asp:Image ID="imgProduct" runat="server" CssClass="product-image" />
        </div>

    </div>
</asp:Content>
