namespace PayPoint.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.TodoItems",
                c => new
                    {
                        TodoItemId = c.Int(nullable: false, identity: true),
                        Title = c.String(nullable: false),
                        IsDone = c.Boolean(nullable: false),
                        TodoListId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.TodoItemId)
                .ForeignKey("dbo.TodoLists", t => t.TodoListId, cascadeDelete: true)
                .Index(t => t.TodoListId);
            
            CreateTable(
                "dbo.TodoLists",
                c => new
                    {
                        TodoListId = c.Int(nullable: false, identity: true),
                        UserId = c.String(nullable: false),
                        Title = c.String(nullable: false),
                    })
                .PrimaryKey(t => t.TodoListId);
            
            CreateTable(
                "dbo.Products",
                c => new
                    {
                        ProductId = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        SKU = c.String(),
                        Category = c.String(),
                        Brand = c.String(),
                        Model = c.String(),
                        SerialNumber = c.String(),
                        IMEI1 = c.String(),
                        IMEI2 = c.String(),
                        BarCode = c.String(),
                        ProductCode = c.String(),
                        ProductType = c.String(),
                        CostPrice = c.Decimal(precision: 18, scale: 2),
                        UnitPrice = c.Decimal(precision: 18, scale: 2),
                        Quantity = c.Decimal(precision: 18, scale: 2),
                        Status = c.Int(),
                        StockUpdate = c.DateTime(),
                        StockSold = c.DateTime(),
                        CreatedBy = c.String(),
                    })
                .PrimaryKey(t => t.ProductId);
            
            CreateTable(
                "dbo.Orders",
                c => new
                    {
                        OrderId = c.Int(nullable: false, identity: true),
                        OrderNumber = c.String(),
                        Item = c.String(),
                        BarCode = c.String(),
                        Quantity = c.Decimal(precision: 18, scale: 2),
                        VAT = c.Decimal(precision: 18, scale: 2),
                        Discount = c.Decimal(precision: 18, scale: 2),
                        Price = c.Decimal(precision: 18, scale: 2),
                        AmountReceived = c.Decimal(precision: 18, scale: 2),
                        Status = c.String(),
                        PaymentType = c.String(),
                        CreatedTime = c.DateTime(),
                        CreatedBy = c.String(),
                    })
                .PrimaryKey(t => t.OrderId);
            
            CreateTable(
                "dbo.Categories",
                c => new
                    {
                        CategoryId = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.CategoryId);
            
            CreateTable(
                "dbo.Models",
                c => new
                    {
                        ModelId = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.ModelId);
            
            CreateTable(
                "dbo.Brands",
                c => new
                    {
                        BrandId = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.BrandId);
            
        }
        
        public override void Down()
        {
            DropIndex("dbo.TodoItems", new[] { "TodoListId" });
            DropForeignKey("dbo.TodoItems", "TodoListId", "dbo.TodoLists");
            DropTable("dbo.Brands");
            DropTable("dbo.Models");
            DropTable("dbo.Categories");
            DropTable("dbo.Orders");
            DropTable("dbo.Products");
            DropTable("dbo.TodoLists");
            DropTable("dbo.TodoItems");
        }
    }
}
