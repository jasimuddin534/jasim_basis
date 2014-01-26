using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface INoteRepository
    {

        IEnumerable<Note> GetNotes(int companyID);
        IEnumerable<Note> GetNoteByID(long noteID, int companyID);
        IEnumerable<Note> GetNotesByName(string name, int companyID);
        long InsertOrUpdateNote(Note note);
        void DeleteNoteByID(long noteID);
    }
}
