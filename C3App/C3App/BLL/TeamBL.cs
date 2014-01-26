using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class TeamBL
    {
       
        private ITeamRepository teamRepository;

        public TeamBL()
        {
            this.teamRepository = new TeamRepository();
        }

        public IEnumerable<Team> GetTeams()
        {
            return teamRepository.GetTeams();
        }

        public string GetTeamSetNameByID(int teamsetid)
        {
            return teamRepository.GetTeamSetNameByID(teamsetid);
        }

        public IEnumerable<TeamSet> GetTeamSets(string nameSearchString)
        {
            return teamRepository.GetTeamSets(nameSearchString);
        }

        public string GetTeamSetName(long teamid)
        {
            return teamRepository.GetTeamSetName(teamid);
        }

        public IEnumerable<TeamSet> SetTeamSets(string name)
        {
            return teamRepository.SetTeamSets(name);
        }

        public void SetTeamSetIDinUsers(long teamid, int teamsetid)
        {
            try
            {
                teamRepository.SetTeamSetIDinUsers(teamid, teamsetid);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int GetTeamSetID(long teamid)
        {
            return teamRepository.GetTeamSetID(teamid);
        }

        public IEnumerable<Team> GetTeamsByID(long tid)
        {
            return teamRepository.GetTeamsByID(tid);
        }

        public IEnumerable<User> GetUsersByTeamID(Int64 teamid)
        {
            return teamRepository.GetUsersByTeamID(teamid);
        }

        public IEnumerable<User> GetTeamUsers(Int64 teamid, string nameSearchString)
        {
            return teamRepository.GetTeamUsers(teamid,nameSearchString);
        }

        public IEnumerable<Team> GetTeamsByName(string nameSearchString)
        {
            return teamRepository.GetTeamsByName(nameSearchString);
        }

        public IEnumerable<Team> GetTeamsByCompanyID()
        {
            return teamRepository.GetTeamsByCompanyID();
        }

        public IEnumerable<TeamSet> GetTeamSetsByCompanyID()
        {
            return teamRepository.GetTeamSetsByCompanyID();
        }


        public IEnumerable<User> GetUsersByTeam(Int64 teamid)
        {
            return teamRepository.GetUsersByTeam(teamid);
        }

        public void DeactivateTeam(long teamid)
        {
            try
            {
               teamRepository.DeactivateTeam(teamid);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UsersSetTeamID(long uid, long tid)
        {
            try
            {
                teamRepository.UsersSetTeamID(uid,tid);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public Int64 TeamsInsertOrUpdate(Team team)
        {
             ValidateTeam(team);
             return teamRepository.TeamsInsertOrUpdate(team);
           
        }

        private void ValidateTeam(Team team)
        {
            string name = team.Name;
            long id = team.TeamID;
            bool oneteam = teamRepository.SearchTeam(name, id);
            if (oneteam == true)
            {
                throw new TeamException(String.Format("This Team name already exists. Please try another one.", name));
            }
        }


        public partial class TeamException : Exception
        {
            public TeamException(string message)
                : base(message)
            {
            }
        }


    }
}