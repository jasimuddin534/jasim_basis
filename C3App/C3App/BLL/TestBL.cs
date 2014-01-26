using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;

namespace C3App.BLL
{
    public class TestBL
    {
        private TestRepository testRepository;

        public TestBL()
        {
            this.testRepository = new TestRepository();
        }

        public DataTable GetUsers()
        {
            return testRepository.GetUsers();
        }
    }
}