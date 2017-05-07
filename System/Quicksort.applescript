
-- From http://veritrope.com/code/quicksort/

-- -- There are two "handlers" here - 1 - On QuickSort 2 - On ListSort These are from Beginning AppleScript by Stephen Kochan. The ListSort handler is just
-- a "wrapper" for the QuickSort handler. You call ListSort with a paramater that is a List variable, and ListSort tells QuickSort to sort the List
-- beginning with the first item of the List and ending with the last item. If you want to begin or end with other items, call QuickSort directly.

-- ListHandlers

on listSort(L)
    return quicksort(L, 1, count L)
end listSort

on quicksort(L, leftIndex, rightIndex)
    if L = {} then return L

    set lHold to leftIndex
    set rHold to rightIndex

    set |pivot| to item leftIndex of L

    repeat while leftIndex < rightIndex
        repeat while item rightIndex of L ≥ |pivot| and leftIndex < rightIndex
            set rightIndex to rightIndex - 1
        end repeat

        if leftIndex is not equal to rightIndex then
            set item leftIndex of L to item rightIndex of L
            set leftIndex to leftIndex + 1
        end if

        repeat while item leftIndex of L ≤ |pivot| and leftIndex < rightIndex
            set leftIndex to leftIndex + 1
        end repeat

        if leftIndex is not equal to rightIndex then
            set item rightIndex of L to item leftIndex of L
            set rightIndex to rightIndex - 1
        end if
    end repeat

    set item leftIndex of L to |pivot|
    set oldLeft to leftIndex
    set leftIndex to lHold
    set rightIndex to rHold

    if leftIndex < oldLeft then
        quicksort(L, oldLeft + 1, rightIndex)
    end if

    return L
end quicksort
