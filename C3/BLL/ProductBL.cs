using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class ProductBL
    {

         private readonly IProductRepository productRepository;
       
         public ProductBL()
         {
            this.productRepository = new ProductRepository();
         }

        //get product
          public IEnumerable<Product> GetProducts()
          {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return productRepository.GetProducts(companyID);
          }

          public IEnumerable<Product> GetProductByID(long productID)
          {
              int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
              return productRepository.GetProductByID(productID, companyID);
          }

        public void InsertProduct(Product product)
        {
            try
            {
                ValidateProduct(product);
                productRepository.InsertProduct(product);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
      
        public void UpdateProduct(Product product)
        {
            try
            {
                ValidateProduct(product);
                productRepository.UpdateProduct(product);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void DeleteProduct(long productID)
        {
            productRepository.DeleteProduct(productID);
        }

        //public void DeleteProductByID(long productID)
        //{
        //    productRepository.DeleteProductByID(productID);
        //}

        public IEnumerable<Product> SearchProduct(string search)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return productRepository.SearchProduct(search, companyID);
        }

        public IEnumerable<Product> GetProductsByMobileCategory()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return productRepository.GetProductsByMobileCategory(companyID);
        }

        public IEnumerable<Product> GetProductsByCarCategory()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return productRepository.GetProductsByCarCategory(companyID);
        }

        public IEnumerable<Product> GetAvailableProducts()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return productRepository.GetAvailableProducts(companyID);
        }

        public List<ProductStatus> GetProductStatuses()
        {
           return productRepository.GetProductStatuses();
        }

        public List<ProductCategory> GetProductCategories()
        {
            return productRepository.GetProductCategories();
        }

        public string GetSupportTermByProductID(long productID)
        {
            return productRepository.GetSupportTermByProductID(productID);      
        }

         public List<Manufacturer> GetManufacturers()
         {
             return productRepository.GetManufacturers();
         }

       public List<ProductType> GetProductTypes()
       {
           return productRepository.GetProductTypes();
       }
        public List<Discount> GetDiscounts()
        {
            return productRepository.GetDiscounts();
        }

       public  List<PricingFormula> GetPricingFormulas()
       {
           return productRepository.GetPricingFormulas();
       }

       //public IEnumerable<Product> GetSingleProductByID(long productID)
       //{
       //    return productRepository.GetSingleProductByID(productID);
       //}

       private void ValidateProduct(Product product)
       {
           if(product.ProductID!=null)
           {
               var duplicateProduct = productRepository.GetProduct(product).FirstOrDefault();
               if (duplicateProduct != null && duplicateProduct.ProductID != product.ProductID)
               {
                   if (duplicateProduct.SKU == product.SKU)
                   {
                       throw new ProductException(String.Format("Product {0} already exists", duplicateProduct.Name, duplicateProduct.SKU));
                   }
                   //if (duplicateProduct.Name == product.Name)
                   //{
                   //    throw new ProductException(String.Format("Product {0} already exists", duplicateProduct.Name, duplicateProduct.SKU));
                   //}
               }
           }
       }
    }

    public partial class ProductException : Exception
    {
        public ProductException(string message)
            : base(message)
        {
        }
    }
}