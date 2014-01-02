using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class QuoteRepository : IDisposable, IQuoteRepository
    {
        private C3Entities context = new C3Entities();



        //public void InitalizeDataColumns()
        //{


        //}

        public IEnumerable<Quote> GetQuotes(int companyId)
        {
            var Quotes = (context.Quotes.Where(Quote => Quote.IsDeleted == false && Quote.CompanyID == companyId).
                OrderBy(Quote => Quote.Name).Take(20));
            return Quotes;
        }

        public IEnumerable<QuoteStage> GetQuoteStages()
        {
            return context.QuoteStages.ToList();
        }
        public IEnumerable<PaymentTerm> GetPaymentTerms()
        {
            return context.PaymentTerms.ToList();
        }

        private bool disposevalue = false;
        public virtual void Dispose(bool disposing)
        {
            if (!this.disposevalue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
        }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }


        public long InsertQuote(Quote Quote)
        {
            try
            {


                Quote.CreatedTime = DateTime.Now;
                Quote.ModifiedTime = DateTime.Now;
                context.Entry(Quote).State = EntityState.Added;
                context.SaveChanges();
                return Quote.QuoteID;
            }
            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }
        }
        public long UpdateQuote(Quote Quote)
        {
            try
            {

                var currentQuote = context.Quotes.Find(Quote.QuoteID);
                context.Entry(currentQuote).CurrentValues.SetValues(Quote);
                //Quote.ModifiedTime = DateTime.Now;
                // context.Entry(Quote).State=EntityState.Modified;

                SaveChanges();
                return Quote.QuoteID;
            }
            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }
        }
        public void DeleteQuote(Quote Quote)
        {
            try
            {
                context.Quotes.Attach(Quote);
                context.Entry(Quote).State = EntityState.Deleted;
                SaveChanges();
            }
            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }
        }
        public IEnumerable<Quote> QuoteByID(long QuoteID)
        {

            var Quotes = (context.Quotes.Where(Quote => Quote.QuoteID == QuoteID)).ToList();
            return Quotes;

        }
        public IEnumerable<Quote> SearchQuotes(string search, int companyId)
        {
            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }

            var Quotes = (context.Quotes.Where(Quote => Quote.Name.Contains(search) && (Quote.IsDeleted == false) && (Quote.CompanyID == companyId))
                         ).ToList();

            return Quotes;
        }

        public void DeleteById(long QuoteId)
        {
            Quote Quotes = (context.Quotes.Where(Quote => Quote.QuoteID == QuoteId)
                           ).FirstOrDefault();
            Quotes.IsDeleted = true;
            try
            {
                context.Entry(Quotes).State = EntityState.Modified;
                SaveChanges();

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public IEnumerable<QuoteDetail> GetQuoteDetails()
        {
            var Quotes = (context.QuoteDetails.Where(Quote => Quote.IsDeleted == false)).ToList();

            return Quotes;

        }

        public void InsertQuoteDetails(QuoteDetail QuoteDetail)
        {
            try
            {
                QuoteDetail.CreatedTime = DateTime.Now;
                QuoteDetail.ModifiedTime = DateTime.Now;
                //context.Entry(QuoteDetail).State = EntityState.Added;
                //context.SaveChanges();
                context.Entry(QuoteDetail).State = QuoteDetail.QuoteLineID == 0 ? EntityState.Added : EntityState.Modified;
                context.SaveChanges();
            }


            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }

        }

        public void UpdateQuoteDetails(QuoteDetail QuoteDetail)
        {
            try
            {

                QuoteDetail.ModifiedTime = DateTime.Now;
                context.Entry(QuoteDetail).State = EntityState.Modified;
                SaveChanges();

            }
            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }

        }

        public DataRow ProductsQuoteDetail(IEnumerable<Product> products)
        {
            // this.InitalizeDataColumns();
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn = new DataColumn();
            myDataColumn.AllowDBNull = false;
            myDataColumn.AutoIncrement = true;
            myDataColumn.AutoIncrementSeed = 1;
            myDataColumn.AutoIncrementStep = 1;

            myDataColumn.ColumnName = "Quantity";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataColumn.Unique = true;
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Name";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "MftPartNum";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "CostPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "ListPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "UnitPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "ExtendedPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Discount";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            DataRow dataRow = myDataTable.NewRow();

            foreach (var product in products)
            {

                dataRow["Quantity"] = product.Quantity;
                dataRow["Name"] = product.Name;
                dataRow["MftPartNum"] = product.MFTPartNumber;
                dataRow["CostPrice"] = product.Cost;
                dataRow["ListPrice"] = product.ListPrice;
                //dataRow["UnitPrice"] = product.UnitPrice;
                dataRow["ExtendedPrice"] = "34";
                dataRow["Discount"] = "344";
                myDataTable.Rows.Add(dataRow);
            }
            return myDataTable.Rows[0];

        }

        public IEnumerable<Quotes.Quotes.CustomQuoteDetails> GetQuoteDetailsByID(long Quoteid)
        {
            //Quotes.Quotes.CustomQuoteDetails customQuoteDetails=new Quotes.Quotes.CustomQuoteDetails();
            List<Quotes.Quotes.CustomQuoteDetails> customQuoteDetailses = new List<Quotes.Quotes.CustomQuoteDetails>();
            var Quotedetails = (context.QuoteDetails.Where(QuoteDetail => QuoteDetail.QuoteID == Quoteid && QuoteDetail.IsDeleted == false).
               Select(QuoteDetail => new
               {
                   quantity = QuoteDetail.Quantity,
                   productname = QuoteDetail.Product.Name,
                   MftPartNum = QuoteDetail.Product.MFTPartNumber,
                   cost = QuoteDetail.Cost,
                   list = QuoteDetail.ListPrice,
                   discount = QuoteDetail.Discount,
                   note = QuoteDetail.Note,
                   productid = QuoteDetail.ProductID,
                   QuoteLineID = QuoteDetail.QuoteLineID
               })).ToList();
            foreach (var od in Quotedetails)
            {
                Quotes.Quotes.CustomQuoteDetails customQuoteDetails = new Quotes.Quotes.CustomQuoteDetails();
                customQuoteDetails.Quantity = od.quantity;
                customQuoteDetails.MftPartNum = od.MftPartNum;
                customQuoteDetails.Name = od.productname;
                customQuoteDetails.Cost = od.cost;
                customQuoteDetails.List = od.list;
                customQuoteDetails.Discount = od.discount;
                customQuoteDetails.Note = od.note;
                customQuoteDetails.ProductID = od.productid;
                customQuoteDetails.QuoteLineID = od.QuoteLineID;
                customQuoteDetailses.Add(customQuoteDetails);

            }

            return customQuoteDetailses;
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

        public bool ProductRowDelete(long QuoteLineId)
        {
            //    Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            //    var QuoteDetails = (context.QuoteDetails.Where(QuoteDetail => QuoteDetail.QuoteLineID == QuoteLineId)).ToList();

            //    if (QuoteDetails.Count() > 0)
            //    {
            //        QuoteDetail QuoteDetail = (context.QuoteDetails.Where(QuoteDetails => QuoteDetails.QuoteLineID == QuoteLineId)).FirstOrDefault();
            //        QuoteDetail.IsDeleted = true;
            //        QuoteDetail.CreatedTime = DateTime.Now;
            //        QuoteDetail.ModifiedTime = DateTime.Now;
            //        QuoteDetail.ModifiedBy = userid;
            //        try
            //        {
            //            context.Entry(QuoteDetail).State = EntityState.Modified;
            //            SaveChanges();
            //            return true;
            //        }
            //        catch (Exception ex)
            //        {

            //            throw ex;
            //        }

            //    }
            //    else
            //    {
            //        return false;
            //    }


            return false;

        }

        


        public IEnumerable<Quote> GetLeadByContactID(string QuoteNumber, int companyid)
        {
            return context.Quotes.Where(p => p.QuoteNumber == QuoteNumber && p.CompanyID == companyid).ToList();

        }

        public IEnumerable<Quote> ConvertquoteByID(long quoteId)
        {
            throw new NotImplementedException();
        }


        public IEnumerable<Quote> ConvertQuoteByID(long QuoteId)
        {
        //    var Quotes = (context.Quotes.Where(Quote => Quote.QuoteID == QuoteId && Quote.Converted == false)).ToList();
        //    return Quotes;
            throw new NotImplementedException();

        }

        public void UpdateConvertQuote(long QuoteId)
        {
        //    Quote Quote1 = (context.Quotes.Single(Quote => Quote.QuoteID == QuoteId));
        //    Quote1.Converted = true;
        //    context.SaveChanges();

        }

        public string GetQuoteNumber(int companyId)
        {
           //var Quotenumber = (context.Quotes.Where(Quote => Quote.CompanyID == companyId).QuoteByDescending
           //    (Quote => Quote.QuoteID).Select(Quote => Quote.QuoteNumber)).FirstOrDefault();
            var Quotenumber = (from quote in context.Quotes
                               where quote.CompanyID == companyId
                               orderby quote.QuoteID descending
                               select quote.QuoteNumber).FirstOrDefault();
            
           return Quotenumber;
            throw new NotImplementedException();

        }

        public bool ApproveQuote(long QuoteId)
        {
        //    bool msg = false;
        //    try
        //    {
        //        var Quote = (context.Quotes.Where(Quote1 => Quote1.QuoteID == QuoteId && Quote1.IsApproved == false)).FirstOrDefault();
        //        if (Quote != null)
        //        {
        //            Quote.IsApproved = true;
        //            context.SaveChanges();
        //            msg = true;
        //        }

        //    }
        //    catch (Exception ec)
        //    {
        //        throw ec;
        //    }
        //    return msg;
            throw new NotImplementedException();

        }

        public IEnumerable<QuoteDetail> GetQuoteDetailsByQuoteID(long QuoteId)
        {
            var Quotedetails = (context.QuoteDetails.Where(
                QuoteDetail => QuoteDetail.QuoteID == QuoteId && QuoteDetail.IsDeleted == false)).ToList();
            return Quotedetails;
        }

        public IEnumerable<Quote> SearchInvoiceQuotes(int companyID, string search)
        {
            //if (String.IsNullOrWhiteSpace(search))
            //{
            //    search = "";
            //}

            //var Quotes = (context.Quotes.Where(Quote => Quote.Name.Contains(search) && (Quote.IsDeleted == false) && Quote.Converted == false &&
            //             Quote.CompanyID == companyID)).ToList();
            //return Quotes;
            throw new NotImplementedException();


        }

        public IEnumerable<Quote> GetApprovedQuotes(int companyId)
        {
            //var Quotes = (context.Quotes.Where(Quote => Quote.IsApproved == true && Quote.CompanyID == companyId && Quote.IsDeleted == false)).ToList();
            //return Quotes;
            throw new NotImplementedException();

        }

        public IEnumerable<Quote> GetUnApprovedQuotes(int companyId)
        {
            //var Quotes = (context.Quotes.Where(Quote => Quote.IsApproved == false && Quote.CompanyID == companyId && Quote.IsDeleted == false)).ToList();
            //return Quotes;
            throw new NotImplementedException();

        }

    }
}