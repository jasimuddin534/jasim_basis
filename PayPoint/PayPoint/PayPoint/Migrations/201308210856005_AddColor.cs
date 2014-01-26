namespace PayPoint.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddColor : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Products", "Color", c => c.String());
            AddColumn("dbo.Products", "suppliers", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Products", "suppliers");
            DropColumn("dbo.Products", "Color");
        }
    }
}
