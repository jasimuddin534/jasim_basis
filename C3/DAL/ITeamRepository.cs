using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface ITeamRepository
    {
        IEnumerable<Team> GetTeamsByID(long tid);
        IEnumerable<User> GetUsersByTeamID(Int64 teamid);
        IEnumerable<Team> GetTeamsByName(string nameSearchString);
        IEnumerable<Team> GetTeamsByCompanyID();
        IEnumerable<Team> GetTeams();
        IEnumerable<TeamSet> GetTeamSetsByCompanyID();
        void UsersSetTeamID(long uid, long tid);
        Int64 TeamsInsertOrUpdate(Team team);
        IEnumerable<User> GetUsersByTeam(Int64 teamid);
        void DeactivateTeam(long teamid);
        IEnumerable<User> GetTeamUsers(Int64 teamid, string nameSearchString);
        string GetTeamSetName(long teamid);
        int GetTeamSetID(long teamid);
        void SetTeamSetIDinUsers(long teamid, int teamsetid);
        IEnumerable<TeamSet> SetTeamSets(string name);
        IEnumerable<TeamSet> GetTeamSets(string nameSearchString);
        string GetTeamSetNameByID(int teamsetid);
        bool SearchTeam(string nameSearchString, long tid);
    }
}
