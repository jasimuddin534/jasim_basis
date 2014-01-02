using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;
using System.Data;
using System.Data.Entity.Infrastructure;

namespace C3App.DAL
{
    public class TaskRepository : IDisposable, ITaskRepository
    {
        private C3Entities context = new C3Entities();

        public TaskRepository()
        {
        }


        public IEnumerable<Task> GetTasks(int companyID)
        {

            return context.Tasks.AsNoTracking().Where(c => c.CompanyID == companyID && c.IsDeleted == false).Take(20).ToList();

           //var tasks = (from task in context.Tasks where task.IsDeleted == false && task.CompanyID == companyID
           //             select task).Take(20).ToList();
           // try
           // {
           //     return tasks;
           // }
           // catch (OptimisticConcurrencyException ocex)
           // {
           //     throw ocex;
           // }
        }

        public IEnumerable<Task> GetTaskByID(long taskID, int companyID)
        {
            var tasks= (from task in context.Tasks where task.TaskID == taskID && task.IsDeleted == false && task.CompanyID == companyID
                        select task).ToList();
            try
            {
                return tasks;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Task> GetTaskBySubject(string subjectSearch, int companyID)
        {
            if (String.IsNullOrWhiteSpace(subjectSearch))
            {
                subjectSearch = "";
            }
            try
            {
                return context.Tasks.Where(task => task.IsDeleted == false && task.CompanyID == companyID && task.Subject.Contains(subjectSearch)).ToList();
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        public IEnumerable<Task> GetNotStartedTask(int companyID)
        {
            var tasks = (from task in context.Tasks
                         where task.IsDeleted == false && task.CompanyID == companyID && task.StatusID == 1
                         select task).ToList();
            try
            {
                return tasks;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Task> GetInProgressTask(int companyID)
        {
            var tasks = (from task in context.Tasks
                         where task.IsDeleted == false && task.CompanyID == companyID && task.StatusID == 2
                         select task).ToList();
            try
            {
                return tasks;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Task> GetCompletedTask(int companyID)
        {
            var tasks = (from task in context.Tasks
                         where task.IsDeleted == false && task.CompanyID == companyID && task.StatusID == 3
                         select task).ToList();
            try
            {
                return tasks;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        

        public IEnumerable<TaskStatus> GetTaskStatuses()
        {
            try
            {
                return context.TaskStatuses.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public IEnumerable<Task> GetTaskByAssignedUser(int companyID, int uid)
        {
            var tasks = (from task in context.Tasks
                         where task.IsDeleted == false && task.CompanyID == companyID && task.AssignedUserID==uid
                         select task).ToList();
            try
            {
                return tasks;
            }
            catch (OptimisticConcurrencyException ocex)
            {
                throw ocex;
            }
        }

        public long InsertOrUpdateTask(Task task)
        {
            try
            {
                context.Entry(task).State = task.TaskID == 0 ? EntityState.Added : EntityState.Modified;
                SaveChanges();
                return task.TaskID;
            }
            catch (Exception ex) { throw ex; }
        }

        public void DeleteTaskByID(long taskID)
        {
            Task tasks = (from task in context.Tasks
                          where task.TaskID == taskID
                          select task).FirstOrDefault();

            try
            {
                tasks.IsDeleted = true;
                context.Entry(tasks).State = EntityState.Modified;
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