using System;
using System.Collections.Generic;
using System.DirectoryServices.AccountManagement;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using MvcApplication.Models;

namespace Extractor
{
    public class UserSucker
    {
        HashSet<string> offices = new HashSet<string>();

        public void Suck()
        {
            List<User> users = SuckAndSort();

            System.Console.WriteLine("--------------------");

            SaveSuckedUsers(users);

            System.Console.ReadLine();
        }

        private static List<User> SuckAndSort()
        {
            List<User> suckedUsers = new UserFilter(ActiveDirectoryHelper.DomainContext).FindAllEnabledWithEmails();
            suckedUsers.Sort((User left, User right) => left.Name.CompareTo(right.Name));
            return suckedUsers;
        }

        private void SaveSuckedUsers(List<User> results)
        {
            using (FileStream stream = File.Create(Path.Combine(Environment.CurrentDirectory, "users.csv")))
            {
                using (StreamWriter writer = new StreamWriter(stream))
                {
                    WriteUsersToFile(results, writer);
                }
            }
        }

        private void WriteUsersToFile(List<User> results, StreamWriter writer)
        {
            foreach (User user in results)
            {
                string line = user.Name + ", " + user.EmailAddress + ", " + Office(user.DistinguishedName);
                Console.WriteLine(line);
                writer.WriteLine(line);
            }

            foreach (string office in offices)
            {
                Console.Write(office + ", ");
            }
        }

        private string Office(string dn)
        {
            string lower = dn.ToLower();
            string[] chunks = lower.Split(',');
            string office = chunks[1].Replace("ou=", "");

            offices.Add(office);
            return office;

//            string lowerDn = dn.ToLower();
//            int left = lowerDn.IndexOf("ou=") + 3;
//            return dn.Substring(left, 10);
//            return dn;
        }
    }
}
