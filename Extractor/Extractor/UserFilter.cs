using System;
using System.Collections.Generic;
using System.DirectoryServices.AccountManagement;

namespace Extractor
{
    public class UserFilter
    {
        private readonly PrincipalContext context;

        public UserFilter(PrincipalContext context)
        {
            this.context = context;
        }

        public List<User> FindMatching(UserPrincipal filterCriteria)
        {
            List<User> results = new List<User>();

            PrincipalSearcher principalSearcher = new PrincipalSearcher();

            principalSearcher.QueryFilter = filterCriteria;

            PrincipalSearchResult<Principal> principals = principalSearcher.FindAll();
            foreach (UserPrincipal userPrincipal in principals)
            {
                results.Add(new User(userPrincipal));
            }
            results = results ?? new List<User>();
            return results;
        }

        public List<User> FindByName(string pattern)
        {
            UserPrincipal filterCriteria = new UserPrincipal(context);

            filterCriteria.Name = pattern;
            return FindMatching(filterCriteria);
        }


        public List<User> FindAllEnabledWithEmails()
        {
            UserPrincipal filterCriteria = new UserPrincipal(context);
            filterCriteria.Enabled = true;

            List<User> users = FindMatching(filterCriteria);
            users.RemoveAll( (User user) => user.EmailAddress == null || user.EmailAddress.Trim().Length == 0 );
            return users;
        }
    }
}