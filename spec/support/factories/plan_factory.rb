FactoryGirl.define do
  factory :starter_plan, :class => Subscribem::Plan do
    name "Starter"
    price 9.95
    braintree_id "starter"
  end

  factory :extreme_plan, :class => Subscribem::Plan do
    name "Extreme"
    price 19.95
    braintree_id "extreme"
  end
end