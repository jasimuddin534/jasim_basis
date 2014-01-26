namespace PayPoint.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddColor1 : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Products", "suppliers");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Products", "suppliers", c => c.String());
        }
    }
}
