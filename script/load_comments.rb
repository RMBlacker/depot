Comment.transaction do
  (1..100).each do |i|
    Order.create(:product_id => i%4,
                  :user_id => 1,
                  :content =>"#{i}haohaohaohaogood")
  end
end