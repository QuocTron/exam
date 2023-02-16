using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Services.PSO
{

    public static class PSOExtension
    {
        public static List<CauHoi> GetBySum(this IOrderedEnumerable<IGrouping<long, CauHoi>> groups, int sum)
        {
            List<CauHoi> result = new List<CauHoi>();
            List<IGrouping<long, CauHoi>> group = new List<IGrouping<long, CauHoi>>(groups);

            if (group.Count == 0) { return result; }
            if (group.Max(c => c.Count()) < 2)
            {
                return group.Take(sum).SelectMany(c => c).ToList();
            }

            int n = group.Count();
            bool[][] subset = new bool[n + 1][];

            for (int i = 0; i <= n; i++)
            {
                subset[i] = new bool[sum + 1];
                subset[i][0] = true;
            }
            for (int i = 1; i <= sum; i++)
            {
                subset[0][i] = false;
            }

            for (int i = 1; i <= n; i++)
            {
                for (int j = 1; j <= sum; j++)
                {
                    int countOfGroup = group.ElementAt(i - 1).Count();
                    if (j < countOfGroup)
                    {
                        subset[i][j] = subset[i - 1][j];
                    }
                    if (j >= countOfGroup)
                    {
                        subset[i][j] = subset[i - 1][j] || subset[i - 1][j - countOfGroup];
                    }
                }


                if (subset[i][sum])
                {
                    int temp = sum;
                    while (temp > 0)
                    {
                        if (!subset[i - 1][temp])
                        {
                            temp = temp - group.ElementAt(i - 1).Count();
                            result.AddRange(group.ElementAt(i - 1).Select(c => c));
                            i = i - 1;
                        }
                        else
                        {
                            i = i - 1;
                        }
                    }
                    return result;
                }
            }
            return result;
        }

        public static List<CauHoi> GetContiguousBySum(this IOrderedEnumerable<IGrouping<long, CauHoi>> groups, int sum)
        {
            List<CauHoi> result = new List<CauHoi>();
            List<IGrouping<long, CauHoi>> group = new List<IGrouping<long, CauHoi>>(groups);

            int n = group.Count();
            if (n == 0) { return result; }
            int curr_sum = group[0].Count(), start = 0;

            for (int i = 1; i <= n; i++)
            {
                while (curr_sum > sum && start < i - 1)
                {
                    curr_sum = curr_sum - group[start].Count();
                    start++;
                }

                if (curr_sum == sum)
                {
                    for (int j = start; j < i; j++)
                    {
                        result.AddRange(group[j].Select(c => c));
                    }
                    return result;
                }

                if (i < n)
                {
                    curr_sum = curr_sum + group[i].Count();
                }
            }
            return result;
        }
    }
}
