using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using Extractor;

namespace ExtractorTest
{
    [TestFixture]
    public class NotATest
    {
        [Test]
        public void ShouldSomethingWithLambdasssss()
        {
            //User user = new User(new UserPrinciple());
            //System.Console.WriteLine( (User user) => user.EmailAddress.Length > 0 );

            List<string> strings = new List<string>();
            strings.Add("fuck you microsoft");
            strings.Add("fuck again");

            strings.RemoveAll((string s) => s.Contains("again"));
            System.Console.WriteLine(strings.Count);
        }

        [Test]
        public void ShouldSort()
        {
            List<string> strings = new List<string>();
            strings.Add("fuck you microsoft");
            strings.Add("fuck again");

            strings.Sort((string left, string right) => left.CompareTo(right));
            System.Console.WriteLine(strings[0]);
            System.Console.WriteLine(strings[1]);
        }
    }
}
