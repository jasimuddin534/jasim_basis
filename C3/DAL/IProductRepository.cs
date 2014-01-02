using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IProductRepository
    {
        IEnumerable<Product> GetProducts(int companyID);
        IEnumerable<Product> GetProductByID(long productID,int companyID);
        //IEnumerable<Product> GetSingleProductByID(long productID);
        void InsertProduct(Product product);
        void UpdateProduct(Product product);
        void DeleteProduct(long productID);
       // void DeleteProductByID(long productID);
        IEnumerable<Product> SearchProduct(string search, int companyID);
        List<ProductStatus> GetProductStatuses();
        List<ProductCategory> GetProductCategories();
        string GetSupportTermByProductID(long productID);
        List<Manufacturer> GetManufacturers();
        List<ProductType> GetProductTypes();
        List<Discount> GetDiscounts();
        List<PricingFormula> GetPricingFormulas();
        List<Product> GetProduct(Product product);


        IEnumerable<Product> GetProductsByMobileCategory(int companyID);

        IEnumerable<Product> GetProductsByCarCategory(int companyID);

        IEnumerable<Product> GetAvailableProducts(int companyID);
    }
}
