module LeetCode.MergeTwoSortedLists where
import Data.List

merge :: [Int] -> [Int] -> [Int]
merge [] _ = []
merge _ [] = []
merge arr1 arr2 = sort (arr1 ++ arr2)