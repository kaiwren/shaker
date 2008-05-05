
using System.DirectoryServices.AccountManagement;

namespace MvcApplication.Models
{
    public class ActiveDirectoryHelper
    {
        private static PrincipalContext domainContext = new PrincipalContext(ContextType.Domain);

        public static PrincipalContext DomainContext
        {
            get { return domainContext; }
        }
    }
}