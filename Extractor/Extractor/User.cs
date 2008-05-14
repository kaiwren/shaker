using System.DirectoryServices.AccountManagement;

namespace Extractor
{
    public class User
    {
        private UserPrincipal userPrincipal;

        public string Name
        {
            get { return userPrincipal.Name; }
        }

        public UserPrincipal UserPrincipal
        {
            get { return userPrincipal; }
        }

        public bool IsAccountLockedOut
        {
            get { return userPrincipal.IsAccountLockedOut(); }
        }

        public string EmailAddress
        {
            get { return userPrincipal.EmailAddress;  }
        }

        public string DistinguishedName
        {
            get { return userPrincipal.DistinguishedName; }
        }

        public bool Enabled
        {
            get
            {
                bool? enabled = userPrincipal.Enabled;
                return (enabled != null && enabled == true);
            }
        }

        public User(UserPrincipal userPrincipal)
        {
            this.userPrincipal = userPrincipal;
        }

    }
}