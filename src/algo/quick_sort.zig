const std = @import("std");
const testing = std.testing;
const print = std.debug.print;

fn partition(comptime T: type, arr: []T, low: usize, high: usize, comptime lessThan: fn (T, T) bool) usize {
    const pivot = arr[high];
    var i: usize = low;
    var j: usize = low;
    while (j < high) : (j += 1) {
        if (lessThan(arr[j], pivot)) {
            std.mem.swap(T, &arr[i], &arr[j]);
            i += 1;
        }
    }
    std.mem.swap(T, &arr[i], &arr[high]);
    return i;
}

fn quickSortImpl(comptime T: type, arr: []T, low: usize, high: usize, comptime lessThan: fn (T, T) bool) void {
    if (low < high) {
        const pi = partition(T, arr, low, high, lessThan);
        if (pi > 0) {
            quickSortImpl(T, arr, low, pi - 1, lessThan);
        }
        quickSortImpl(T, arr, pi + 1, high, lessThan);
    }
}

pub fn quickSort(comptime T: type, arr: []T, lessThan: fn (T, T) bool) void {
    if (arr.len > 1) {
        quickSortImpl(T, arr, 0, arr.len - 1, lessThan);
    }
}

fn ascendingOrder(comptime T: type) fn (T, T) bool {
    return struct {
        fn inner(a: T, b: T) bool {
            return a < b;
        }
    }.inner;
}

fn descendingOrder(comptime T: type) fn (T, T) bool {
    return struct {
        fn inner(a: T, b: T) bool {
            return a > b;
        }
    }.inner;
}

test "QuickSort - Integer Ascending" {
    var arr = [_]i32{ 64, 34, 25, 12, 22, 11, 90 };
    quickSort(i32, &arr, ascendingOrder(i32));
    try testing.expectEqual([_]i32{ 11, 12, 22, 25, 34, 64, 90 }, arr);
}

test "QuickSort - Integer Descending" {
    var arr = [_]i32{ 64, 34, 25, 12, 22, 11, 90 };
    quickSort(i32, &arr, descendingOrder(i32));
    try testing.expectEqual([_]i32{ 90, 64, 34, 25, 22, 12, 11 }, arr);
}

test "QuickSort - Float Ascending" {
    var arr = [_]f32{ 64.1, 34.2, 25.3, 12.4, 22.5, 11.6, 90.7 };
    quickSort(f32, &arr, ascendingOrder(f32));
    try testing.expectEqual([_]f32{ 11.6, 12.4, 22.5, 25.3, 34.2, 64.1, 90.7 }, arr);
}

test "QuickSort - Empty Array" {
    var arr = [_]i32{};
    quickSort(i32, &arr, ascendingOrder(i32));
    try testing.expectEqual([_]i32{}, arr);
}

test "QuickSort - Single Element Array" {
    var arr = [_]i32{1};
    quickSort(i32, &arr, ascendingOrder(i32));
    try testing.expectEqual([_]i32{1}, arr);
}

test "QuickSort - Already Sorted Array" {
    var arr = [_]i32{ 1, 2, 3, 4, 5 };
    quickSort(i32, &arr, ascendingOrder(i32));
    try testing.expectEqual([_]i32{ 1, 2, 3, 4, 5 }, arr);
}

test "QuickSort - Reverse Sorted Array" {
    var arr = [_]i32{ 5, 4, 3, 2, 1 };
    quickSort(i32, &arr, ascendingOrder(i32));
    try testing.expectEqual([_]i32{ 1, 2, 3, 4, 5 }, arr);
}

test "QuickSort - Array with Duplicates" {
    var arr = [_]i32{ 3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5 };
    quickSort(i32, &arr, ascendingOrder(i32));
    try testing.expectEqual([_]i32{ 1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9 }, arr);
}
