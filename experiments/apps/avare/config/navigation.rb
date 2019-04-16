# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.items do |primary|
    primary.item :specification, 'Спецификации', specifications_path
    primary.item :upload, 'Загрузка', upload_index_path, :if => Proc.new { can? :manage, Upload }
    primary.item :projects, 'Проекты', projects_path, :if => Proc.new { can? :manage, Project }
    primary.item :categories, 'Классификатор', categories_path, :if => Proc.new { can? :manage, Category }
  end

end
