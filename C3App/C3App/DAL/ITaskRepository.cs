using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface ITaskRepository
    {

        IEnumerable<Task> GetTasks(int companyID);
        IEnumerable<Task> GetTaskByID(long taskID, int companyID);
        IEnumerable<Task> GetTaskBySubject(string subjectSearch, int companyID);

        IEnumerable<Task> GetNotStartedTask(int companyID);
        IEnumerable<Task> GetInProgressTask(int companyID);
        IEnumerable<Task> GetCompletedTask(int companyID);

        IEnumerable<TaskStatus> GetTaskStatuses();
        IEnumerable<Task> GetTaskByAssignedUser(int companyID, int uid);

        void DeleteTaskByID(long taskID);
        long InsertOrUpdateTask(Task task);
    }
}
