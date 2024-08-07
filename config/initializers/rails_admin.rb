RailsAdmin.config do |config|
  # Authentication (if using Devise)
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # Customizing the Admin Name
  config.main_app_name = ["Anizkuro", "Admin"]

  # Exclude models from navigation
  config.excluded_models = ["ActiveStorage::Attachment", "ActiveStorage::Blob"]

  # Configure models
  config.model 'User' do
    list do
      field :id
      field :email
      field :first_name
      field :last_name
      field :created_at
      field :updated_at
    end

    edit do
      field :email
      field :first_name
      field :last_name
      field :password
      field :password_confirmation
    end
  end

  config.model 'Product' do
    list do
      field :id
      field :name
      field :description
      field :price
      field :stock_quantity
      field :category
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :description
      field :price
      field :stock_quantity
      field :category
      field :image, :active_storage
    end
  end

  config.model 'Category' do
    list do
      field :id
      field :name
      field :created_at
      field :updated_at
    end

    edit do
      field :name
    end
  end

  config.model 'Order' do
    list do
      field :id
      field :user
      field :address
      field :subtotal
      field :total_price
      field :status
      field :created_at
      field :updated_at
    end

    edit do
      field :user
      field :address
      field :subtotal
      field :total_price
      field :status
    end
  end

  config.model 'OrderItem' do
    list do
      field :id
      field :order
      field :product
      field :quantity
      field :price
      field :created_at
      field :updated_at
    end

    edit do
      field :order
      field :product
      field :quantity
      field :price
    end
  end

  config.model 'Review' do
    list do
      field :id
      field :user
      field :product
      field :rating
      field :comment
      field :created_at
      field :updated_at
    end

    edit do
      field :user
      field :product
      field :rating
      field :comment
    end
  end

  config.model 'Address' do
    list do
      field :id
      field :user
      field :street
      field :city
      field :province
      field :postal_code
      field :country
      field :created_at
      field :updated_at
    end

    edit do
      field :user
      field :street
      field :city
      field :province
      field :postal_code
      field :country
    end
  end

  config.model 'Province' do
    list do
      field :id
      field :name
      field :created_at
      field :updated_at
    end

    edit do
      field :name
    end
  end

  config.model 'TaxType' do
    list do
      field :id
      field :name
      field :created_at
      field :updated_at
    end

    edit do
      field :name
    end
  end

  config.model 'Tax' do
    list do
      field :id
      field :province
      field :tax_type
      field :rate
      field :effective_date
      field :created_at
      field :updated_at
    end

    edit do
      field :province
      field :tax_type
      field :rate
      field :effective_date
    end
  end

  config.model 'Sale' do
    list do
      field :id
      field :product
      field :sale_price
      field :sale_start_date
      field :sale_end_date
      field :created_at
      field :updated_at
    end

    edit do
      field :product
      field :sale_price
      field :sale_start_date
      field :sale_end_date
    end
  end

  config.model 'Cart' do
    list do
      field :id
      field :user
      field :created_at
      field :updated_at
    end

    edit do
      field :user
    end
  end

  config.model 'CartItem' do
    list do
      field :id
      field :cart
      field :product
      field :quantity
      field :created_at
      field :updated_at
    end

    edit do
      field :cart
      field :product
      field :quantity
    end
  end



  config.model 'ContactPage' do
    edit do
      field :title
      field :content, :text
    end
  end

  config.model 'AboutPage' do
    edit do
      field :title
      field :content, :text
    end
  end


end
