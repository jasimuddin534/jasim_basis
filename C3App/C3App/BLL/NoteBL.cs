using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;

namespace C3App.BLL
{
    public class NoteBL
    {

        private INoteRepository noteRepository;

        public NoteBL()
        {
            this.noteRepository = new NoteRepository();
        }

        public IEnumerable<Note> GetNotes()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return noteRepository.GetNotes(companyID);

        }

        public IEnumerable<Note> GetNoteByID(long noteID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            try
            {
                return noteRepository.GetNoteByID(noteID, companyID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Note> GetNotesByName(string name)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return noteRepository.GetNotesByName(name, companyID);
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
                noteRepository.InsertOrUpdateNote(note);
                return note.NoteID;
            }
            catch (Exception ex) { throw ex; }
        }

        public void DeleteNoteByID(long noteID)
        {
            try
            {
                noteRepository.DeleteNoteByID(noteID);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}