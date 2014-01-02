using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;
using System.Data;

namespace C3App.BLL
{
    public class TaskBL
    {
        private ITaskRepository taskRepository;

        public TaskBL()
        {
            this.taskRepository = new TaskRepository();
        }

        public IEnumerable<Task> GetTasks()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return taskRepository.GetTasks(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Task> GetTaskByID(long taskID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return taskRepository.GetTaskByID(taskID, companyID);
            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public IEnumerable<Task> GetTaskBySubject(string subjectSearch)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return taskRepository.GetTaskBySubject(subjectSearch, companyID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }


        public IEnumerable<Task> GetNotStartedTask()
        {
            try
            {
                int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                return taskRepository.GetNotStartedTask(companyID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Task> GetInProgressTask()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return taskRepository.GetInProgressTask(companyID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Task> GetCompletedTask()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return taskRepository.GetCompletedTask(companyID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public IEnumerable<TaskStatus> GetTaskStatuses()
        {
            try
            {
                return taskRepository.GetTaskStatuses();
            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public IEnumerable<Task> GetTaskByAssignedUser()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            int uid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            try
            {
                return taskRepository.GetTaskByAssignedUser(companyID, uid);
            }
            catch (Exception ocex)
            {
                throw ocex;
            }
        }

        public void DeleteTaskByID(long taskID)
        {
            try
            {
                taskRepository.DeleteTaskByID(taskID);

            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public long InsertOrUpdateTask(Task task)
        {
            try
            {
                return taskRepository.InsertOrUpdateTask(task);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ValidateTask(Task task)
        {
            if (task.Subject != null)
            {
                int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                var duplicateTask = taskRepository.GetTaskByID(task.TaskID, companyID).FirstOrDefault();
                if (duplicateTask != null && duplicateTask.Subject == task.Subject)
                {
                    throw new DuplicateTaskException(String.Format("Task Subject {0} is already exist", duplicateTask.Subject));
                }
            }
        }

    }


    public class DuplicateTaskException : Exception
    {
        public DuplicateTaskException(string message)
            : base(message)
        {
        }
    }
}