using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.Entity.Infrastructure;

namespace C3App.DAL
{
    public class TeamRepository:IDisposable,ITeamRepository
    {
        C3Entities context=new C3Entities();

        public IEnumerable<Team> GetTeamsByID(long tid)
        {

                IEnumerable<Team> team = from p in context.Teams
                                         where (p.TeamID == tid)
                                         select p;
                return team;
          
        }


        public void DeactivateTeam(long teamid)
        {
            Team team = context.Teams.Single(q => q.TeamID == teamid);
            team.IsDeleted = true;
            context.SaveChanges();

        }

        public IEnumerable<User> GetUsersByTeamID(Int64 teamid)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            IEnumerable<User> user = from p in context.Users
                                     where ((p.CompanyID == companyid) && (p.IsDeleted == false) && (p.TeamID == teamid))
                                     select p;
            return user;
        }


        public void SetTeamSetIDinUsers(long teamid, int teamsetid)
        {
            Int64 userid = 0;

            var query = from p in context.Users
                        where (p.TeamID == teamid)
                        select p.UserID;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    userid = q;
                }
            }

            if (userid > 0)
            {
                User user = context.Users.Single(q => q.UserID == userid);
                user.TeamSetID = teamsetid;
                context.SaveChanges();
            }
        }

        public  IEnumerable<TeamSet> SetTeamSets(string name)
        {
            int id = 0;
            string teamsetname = "";
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            var teamset = new TeamSet { TeamSetName=name, CompanyID = companyid, IsDeleted = false, CreatedTime = DateTime.Now, ModifiedTime = DateTime.Now };
            context.TeamSets.Add(teamset);
            context.SaveChanges();

            id = teamset.TeamSetID;
            teamsetname = teamset.TeamSetName;

            return context.TeamSets.Where(d => d.TeamSetID == id).ToList();
        }

        public int GetTeamSetID(long teamid)
        {
           
            int teamset = 0;

            var query = from p in context.Teams
                        where (p.TeamID == teamid)
                        select p.TeamSetID;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    teamset = q;
                }
            }

            return teamset;

        }


        public string GetTeamSetName(long teamid)
        {
            string name = "";

            int teamset = GetTeamSetID(teamid);

            var query = from p in context.TeamSets
                        where (p.TeamSetID == teamset)
                        select p.TeamSetName;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    name = q;
                }
            }

            return name;

        }


        public string GetTeamSetNameByID(int teamsetid)
        {
            string name = "";

            var query = from p in context.TeamSets
                        where (p.TeamSetID == teamsetid)
                        select p.TeamSetName;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    name = q;
                }
            }

            return name;

        }

        public IEnumerable<User> GetUsersByTeam(Int64 teamid)
        {
            int teamset = 0;
          
            teamset = GetTeamSetID(teamid);

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            IEnumerable<User> user = from p in context.Users
                                     where ((p.CompanyID == companyid) && (p.IsDeleted == false) && (p.TeamSetID == teamset))
                                     select p;
            return user;
        }


        public IEnumerable<User> GetTeamUsers(Int64 teamid, string nameSearchString)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";

            }
            
            IEnumerable<User> user = (from p in context.Users
                                     where (((p.FirstName.Contains(nameSearchString)) && (p.CompanyID == companyid) && (p.IsDeleted == false) && (p.TeamID != teamid)))
                                     orderby p.FirstName ascending    
                                     select p).Take(10);
            
            return user;
             
        }

        public IEnumerable<TeamSet> GetTeamSetsByCompanyID()
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);


            IEnumerable<TeamSet> teamset = from p in context.TeamSets
                                           where ((p.CompanyID == companyid) && (p.IsDeleted == false))
                                           select p;
            return teamset;
        }


        public IEnumerable<TeamSet> GetTeamSets(string nameSearchString)
        {

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }


            IEnumerable<TeamSet> teamset = from p in context.TeamSets
                                           where ((p.TeamSetName.Contains(nameSearchString)) && (p.CompanyID == companyid) && (p.IsDeleted == false))
                                           select p;
            return teamset;

     
            //return context.BankAccountsInfoes.ToList();

        }

        public IEnumerable<Team> GetTeamsByName(string nameSearchString)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }

            IEnumerable<Team> team = (from p in context.Teams
                                     where ((p.Name.Contains(nameSearchString)) && (p.CompanyID == companyid) && (p.IsDeleted == false))
                                     orderby p.Name ascending
                                     select p).Take(20);
            return team;


            // return context.Users.Where(d => d.UserName.Contains(nameSearchString)).ToList();
        }


        public IEnumerable<Team> GetTeamsByCompanyID()
        {
            return GetTeamsByName("");
        }


        public IEnumerable<Team> GetTeams()
        {

            return GetTeamsByName("");
        }

        public void UsersSetTeamID(long uid, long tid)
        {
            int teamset = GetTeamSetID(tid);
            User user = context.Users.Single(q => q.UserID == uid);
            user.TeamID = tid;
            user.TeamSetID = teamset;
            context.SaveChanges();

        }

        public long TeamsInsertOrUpdate(Team team)
        {
            long tid = team.TeamID;
            if(tid == 0)
                context.Entry(team).State = EntityState.Added ;
            else
                context.Entry(team).State = EntityState.Modified;
                
            context.SaveChanges();
            long id = team.TeamID;
            return id;
        }


        public bool SearchTeam(string nameSearchString, long tid)
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            bool found = false;
            long teamid = -1;

            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }

            var team = (from p in context.Teams
                        where ((p.Name == nameSearchString) && (p.CompanyID == companyid) && (p.TeamID != tid))
                        select p).FirstOrDefault();

            if (team != null)
                teamid = team.TeamID;

            if (teamid != -1)
                found = true;

            return found;
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
    }
}