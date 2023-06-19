module ProductsHelper
  def thead_tag(header_list, size = :big)
    if size == :small
      style = 'py-4 font-normal text-center dark:text-gray-400'
      th = "<th class=#{style}>"
      raw(header_list.inject('<thead class="text-sm bg-gray-50 text-gray-50 dark:bg-gray-600"> <tr>') { |thead, column| thead + "#{th}#{column}</th>" } + "</tr></thead>")
    else
      style = 'py-4 font-normal text-center dark:text-gray-400'
      th = "<th class=#{style}>"
      raw(header_list.inject('<thead class="text-2xl bg-gray-50 text-gray-50 dark:bg-gray-800"> <tr>') { |thead, column| thead + "#{th}#{column}</th>" } + "</tr></thead>")
    end

  end

  def row_tag(data, *attrib)
    style = 'border text-left px-8 py-4'
    td = "<td class=#{style}>"
    raw attrib.inject("") { |tr, attr| tr + "#{td} <p class='indent-1'>#{data.send(attr)}</p></td>" }
  end
end
