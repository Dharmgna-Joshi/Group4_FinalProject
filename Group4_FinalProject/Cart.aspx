<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Group4_FinalProject.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .cart-actions {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .shopping-button {
            padding: 10px 20px;
            margin-right: 10px;
            border: none;
            color: white;
            text-transform: uppercase;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease-in-out;
            background-color: #f0ad4e; /* Bootstrap 'warning' orange */
            outline: none; /* Removes the focus border */
        }

            .shopping-button:hover {
                background-color: #ec971f; /* A darker orange for hover */
            }


        .empty-button {
            padding: 10px 20px;
            margin-right: 10px;
            border: none;
            color: white;
            text-transform: uppercase;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease-in-out;
            background-color: #d9534f; /* Bootstrap 'danger' red */
            outline: none; /* Removes the focus border */
        }

            .empty-button:hover {
                background-color: #c9302c; /* A darker red for hover */
            }

        .checkout-button {
            padding: 10px 20px;
            margin-right: 10px;
            border: none;
            color: white;
            text-transform: uppercase;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease-in-out;
            background-color: #5cb85c; /* Bootstrap 'success' green */
            outline: none; /* Removes the focus border */
        }

            .checkout-button:hover {
                background-color: #4cae4c; /* A darker green for hover */
            }

        .empty-cart-message {
            display: block;
            color: #d9534f; /* Bootstrap 'danger' red */
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>


    <h2>Cart</h2>

    <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" OnRowCommand="gvCart_RowCommand" CssClass="table">
        <Columns>
            <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />

            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnRemove" runat="server" CommandName="Remove" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Remove" CssClass="btn btn-danger" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div class="cart-actions">
        <asp:Label ID="lblCartEmptyMessage" runat="server" Text="Your cart is empty." Visible="false" CssClass="empty-cart-message"></asp:Label>
        <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" PostBackUrl="~/Products.aspx" CssClass="shopping-button" />
        <asp:Button ID="btnEmptyCart" runat="server" Text="Empty Cart" OnClick="EmptyCart" CssClass="empty-button" />
        <asp:Button ID="btnCheckOut" runat="server" Text="Check Out" PostBackUrl="~/Checkout.aspx" CssClass="checkout-button" />
    </div>

</asp:Content>
