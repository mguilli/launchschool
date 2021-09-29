# frozen_string_literal: true

def transpose(matrix)
  row = matrix[0].size
  col = matrix.size

  new_matrix = Array.new(row) { Array.new(col) }

  row.times do |i|
    col.times do |j|
      new_matrix[i][j] = matrix[j][i]
    end
  end

  new_matrix
end

puts transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
puts transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
result = [[1, 4, 3],
          [2, 3, 7],
          [3, 2, 8],
          [4, 1, 6],
          [5, 0, 2]]
puts transpose([[1, 2, 3, 4, 5],
                [4, 3, 2, 1, 0],
                [3, 7, 8, 6, 2]]) == result
puts transpose([[1]]) == [[1]]
