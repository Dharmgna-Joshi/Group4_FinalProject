<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Group4_FinalProject._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .jumbotron {
        background-color: #f8f9fa;
        padding: 50px;
        margin-bottom: 30px;
        text-align: center;
    }

    .jumbotron h1 {
        font-size: 48px;
        margin-bottom: 20px;
    }

    .jumbotron p {
        font-size: 20px;
        margin-bottom: 20px;
    }

    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        font-size: 20px;
        padding: 10px 20px;
    }

    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #0056b3;
    }

    h2 {
        font-size: 36px;
        margin-bottom: 20px;
    }

    p {
        font-size: 18px;
        margin-bottom: 20px;
    }

    ul {
        list-style-type: none;
        padding: 0;
    }

    ul li {
        font-size: 18px;
        margin-bottom: 10px;
    }
</style>

    <div class="container">
        <div class="jumbotron">
            <h1>Welcome to our Online Electronics Store</h1>
            <p>Discover the latest gadgets, appliances, and electronics!</p>
            <a href="Products.aspx" class="btn btn-primary">Shop Now</a>
        </div>

        <div class="row">
            <div class="col-md-6">
                <h2>About Us</h2>
                <p>We are dedicated to providing high-quality electronic products to our customers at competitive prices. With a wide range of categories including smartphones, laptops, home appliances, and more, we strive to meet all your electronic needs.</p>
            </div>
            <div class="col-md-6">
                <h2>Contact Us</h2>
                <p>If you have any questions or inquiries, feel free to contact us using the information below:</p>
                <ul>
                    <li>Email: info@electronicsstore.com</li>
                    <li>Phone: 123-456-7890</li>
                    <li>Address: 123 Main Street, City, Country</li>
                </ul>
            </div>
        </div>
    </div>

</asp:Content>
