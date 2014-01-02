using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Entity.Infrastructure;
using C3App.DAL;


namespace C3App.DAL
{
    public class NoteRepository : IDisposable, INoteRepository
    {
        private C3Entities context = new C3Entities();


        public NoteRepository() { }




        public IEnumerable<Note> GetNotes(int companyID)
        {

            return context.Notes.AsNoTracking().Where(c => c.CompanyID == companyID && c.IsDeleted == false).Take(20).ToList();

            //var notes = (from note in context.Notes where note.IsDeleted == false && note.CompanyID == companyID
            //             select n).Take(20).ToList();
            // try
            // {
            //     return notes;
            // }
            // catch (OptimisticConcurrencyException ocex)
            // {
            //     throw ocex;
            // }
        }

        public IEnumerable<Note> GetNoteByID(long noteID, int companyID)
        {
            var notes = (from note in context.Notes
                         where note.NoteID == noteID && note.IsDeleted == false && note.CompanyID == companyID
                         select note).ToList();
            try
            {
                return notes;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Note> GetNotesByName(string name, int companyID)
        {
            if (String.IsNullOrWhiteSpace(name))
            {
                name = "";
            }
            try
            {
                return context.Notes.Where(n => n.IsDeleted == false && n.CompanyID == companyID && n.Name.Contains(name)).ToList();
            }
            catch (Exception e)
            {
                throw e;
            }
        }





        public long InsertOrUpdateNote(Note note)
        {
            try
            {
                context.Entry(note).State = note.NoteID == 0 ? EntityState.Added : EntityState.Modified;
                SaveChanges();
                return note.NoteID;
            }
            catch (Exception ex) { throw ex; }
        }

        public void DeleteNoteByID(long noteID)
        {
            Note notes = (from n in context.Notes
                          where n.NoteID == noteID
                          select n).FirstOrDefault();

            try
            {
                notes.IsDeleted = true;
                context.Entry(notes).State = EntityState.Modified;
                SaveChanges();

            }
            catch (OptimisticConcurrencyException e)
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
                    ex.Entries.Single().Reload();
                }
            } while (saveFailed);
        }


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




    }
}