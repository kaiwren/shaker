using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MvcApplication.Models;
using System.IO;

namespace Extractor
{
    public class Program
    {
        static void Main(string[] args)
        {
            new UserSucker().Suck();
        }


    }
}
