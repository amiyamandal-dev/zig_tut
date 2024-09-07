const std = @import("std");

pub fn mergeSort(comptime T: type, arr: []T) !void {
    const temp = try std.heap.page_allocator.alloc(T, arr.len);
    defer std.heap.page_allocator.free(temp);
    _mergeSort(T, arr, temp, 0, arr.len - 1);
}

fn _mergeSort(comptime T: type, arr: []T, temp: []T, low: usize, high: usize) void {
    if (low < high) {
        const mid = (low + high) / 2;
        _mergeSort(T, arr, temp, low, mid);
        _mergeSort(T, arr, temp, mid + 1, high);
        merge(T, arr, temp, low, mid, high);
    }
}

fn merge(comptime T: type, arr: []T, temp: []T, low: usize, mid: usize, high: usize) void {
    var i: usize = low;
    var j: usize = mid + 1;
    var k: usize = low;
    while (i <= mid and j <= high) {
        if (arr[i] <= arr[j]) {
            temp[k] = arr[i];
            i += 1;
        } else {
            temp[k] = arr[j];
            j += 1;
        }
        k += 1;
    }
    while (i <= mid) {
        temp[k] = arr[i];
        i += 1;
        k += 1;
    }
    while (j <= high) {
        temp[k] = arr[j];
        j += 1;
        k += 1;
    }
    var index: usize = 0;
    while (index <= high - low) {
        arr[low + index] = temp[low + index];
        index += 1;
    }
}

test "merge sort" {
    var arr = [_]i32{ 5, 2, 8, 3, 1, 4, 6 };
    try mergeSort(i32, &arr);
    try std.testing.expectEqualSlices(i32, &arr, &[_]i32{ 1, 2, 3, 4, 5, 6, 8 });
}
