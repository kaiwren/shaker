using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using MvcApplication.Models;

namespace Extractor
{
    public class UserSucker
    {
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
                string line = user.Name + ", " + user.EmailAddress;
                System.Console.WriteLine(line);
                writer.WriteLine(line);
            }
        }
    }
}
