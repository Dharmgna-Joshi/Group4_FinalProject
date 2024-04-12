<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Group4_FinalProject.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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
</asp:Content>
