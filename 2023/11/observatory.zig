const std = @import("std");

pub const Galaxy = struct {
    x: u32,
    y: u32,
};

pub const Image = struct {
    width: u32,
    height: u32,
    galaxies: []Galaxy,
};

pub fn sumDistances(image: Image) u64 {
    var result: u64 = 0;

    for (0..image.galaxies.len) |i| {
        for (i + 1..image.galaxies.len) |j| {
            const a = image.galaxies[i];
            const b = image.galaxies[j];
            result += absDiff(a.x, b.x) + absDiff(a.y, b.y);
        }
    }

    return result;
}

fn absDiff(a: u32, b: u32) u32 {
    return if (a > b) a - b else b - a;
}

pub fn expandUniverse(image: *Image, times: u32) !void {
    const orig_width = image.*.width;

    for (0..orig_width) |col_inv| {
        const col = orig_width - col_inv - 1;
        const col_has_galaxy: bool = for (image.*.galaxies) |g| {
            if (g.x == col) {
                break true;
            }
        } else false;

        if (!col_has_galaxy) {
            for (image.*.galaxies) |*g| {
                if (g.x > col) {
                    g.x += times - 1;
                }
            }

            image.*.width += times - 1;
        }
    }

    const orig_height = image.*.height;

    for (0..orig_height) |row_inv| {
        const row = orig_height - row_inv - 1;
        const row_has_galaxy: bool = for (image.*.galaxies) |g| {
            if (g.y == row) {
                break true;
            }
        } else false;

        if (!row_has_galaxy) {
            for (image.*.galaxies) |*g| {
                if (g.y > row) {
                    g.y += times - 1;
                }
            }

            image.*.height += times - 1;
        }
    }
}
