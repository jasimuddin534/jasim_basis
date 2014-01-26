using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    
    public class ProductRepository:IDisposable,IProductRepository
    {
        private C3Entities context = new C3Entities();
       
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        //get all product by pavel
        public IEnumerable<Product> GetProducts(int companyID)
        {
            IEnumerable<Product> products = (context.Products.Where(p => p.CompanyID == companyID && p.IsDeleted == false)).ToList();
            return products;
        }

        public IEnumerable<Product> GetProductByID(long productID, int companyID)
        {
           IEnumerable<Product> products = (context.Products.Where(p => p.ProductID == productID && p.CompanyID == companyID && p.IsDeleted == false)).ToList();
           return products;
        }

        public void InsertProduct(Product product)
        {
            try
            {
                context.Entry(product).State = EntityState.Added;
                SaveChanges();
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
                var currentProduct = context.Products.Find(product.ProductID);
                context.Entry(currentProduct).CurrentValues.SetValues(product);
                SaveChanges();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteProduct(long productID)
        {
            Product product = (context.Products.Where(p => p.ProductID == productID)).FirstOrDefault();

            if (product != null)
            {
                product.IsDeleted = true;
                try
                {
                    context.Entry(product).State = EntityState.Modified;
                    SaveChanges();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                SaveChanges();
            }
        }

        public void SaveChanges()
        {
            bool saveFailed;
            do
            {
                saveFailed = false;
                try
                {
                    context.SaveChanges();
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    saveFailed = true;

                    // Update the values of the entity that failed to save from the store
                    ex.Entries.Single().Reload();

                    // Update original values from the database
                    //var entry = ex.Entries.Single();
                    //entry.OriginalValues.SetValues(entry.GetDatabaseValues());
                }
            } while (saveFailed);
        }

        public IEnumerable<Product> SearchProduct(string search, int companyID)
        {
            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }
            var products = (context.Products.Where(p => p.Name.Contains(search) && (p.IsDeleted == false) && (p.CompanyID == companyID))).ToList();
            return products;
        }

        public IEnumerable<Product> GetProductsByMobileCategory(int companyID)
        {
            var products = (context.Products.Where(p => p.CompanyID == companyID && p.IsDeleted == false && p.CategoryID == 1)).ToList();
            return products;
        }

        public IEnumerable<Product> GetProductsByCarCategory(int companyID)
        {
            var products = (context.Products.Where(p => p.CompanyID == companyID && p.IsDeleted == false && p.CategoryID == 2)).ToList();
            return products;
        }

        public IEnumerable<Product> GetAvailableProducts(int companyID)
        {
            var products = (context.Products.Where(p => p.CompanyID == companyID && p.IsDeleted == false && p.StatusID == 1)).ToList();
            return products;
        }

        public List<ProductStatus> GetProductStatuses()
        {
            var productstatus = (context.ProductStatuses.Select(p => p)).ToList();
            return productstatus;
        }

        public List<Product> GetProduct(Product product)
        {
            var products = (context.Products.Where(p => p.SKU == product.SKU && p.CompanyID==product.CompanyID)).ToList();
            return products;
        }

        public List<ProductCategory> GetProductCategories()
        {
            var productcategory = (context.ProductCategories.Select(p => p)).ToList();
            return productcategory;
        }

        public string GetSupportTermByProductID(long productID)
        {
            string supportterm = "";

            var query = context.Products.Where(p => (p.ProductID == productID)).Select(p => p.SupportTerm);

            if (query.Any())
            {
                foreach (var q in query)
                {
                    supportterm = q;
                }
            }
            else
                supportterm = "N/A";

            return supportterm;
        }

        public List<Manufacturer> GetManufacturers()
        {
            var query = (from p in context.Manufacturers where (p.IsDeleted == false) select p).ToList();
            return query;
        }

        public List<ProductType> GetProductTypes()
        {
            var query = (from p in context.ProductTypes select p).ToList();
            return query;
        }

        public List<Discount> GetDiscounts()
        {
            var query = (from p in context.Discounts select p).ToList();
            return query;
        }

        public List<PricingFormula> GetPricingFormulas()
        {
            var query = (context.PricingFormulas.Select(p => p)).ToList();
            return query;
        }
    }
}