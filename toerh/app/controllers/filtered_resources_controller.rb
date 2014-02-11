class FilteredResourcesController < ActionController::Base

  @@all = false
  @@user = false
  @@licence = false
  @@tag = false
  @@filter = "true"

  protected

  def apply_filters
    if params[:filter].present? && params[:filter].downcase == @@filter
      if params[:user].present?
        @@user = true
      end
      if params[:licence].present?
        @@licence = true
      end
      if params[:tag].present?
        @@tag = true
      end
    else
      @@all = true
    end
  end

  def get_filtered_resources
    @param_count = params.except(:offset, :limit, :action, :format, :controller).length
    temp_resources = Resource.all

    if @@all
      temp_resources = Resource.all
      @@all = false
    end

    if @@user
      temp_resources += get_resources_by_user
      @@user = false
    end

    if @@licence
      temp_resources += get_resources_by_licence
      @@licence = false
    end

    if @@tag
      temp_resources += get_resources_by_tag
      @@tag = false
    end

    if filters_are_set && @param_count > 1
      temp_resources = apply_multiple_filters(temp_resources)
    end

    if params[:limit].present?
      limit = params[:limit].to_i
      if params[:offset].present?
        offset = params[:offset].to_i
        temp_resources_with_limit_and_offset = temp_resources[offset, limit]
        return temp_resources_with_limit_and_offset
      else
        temp_resources_with_limit = temp_resources.first(limit)
        return temp_resources_with_limit
      end
    end

    return temp_resources

  end

  def apply_multiple_filters(temp_resources)
    filtered_resources = Resource.none
    temp_resource_ids = []
    temp_key_array = []

    temp_resources.each do |resource|
      temp_resource_ids << resource.id
    end

    #repeats = temp_resource_ids.length - temp_resource_ids.uniq.length

    h = Hash.new(0)
    temp_resource_ids.each { | v | h.store(v, h[v]+1) }

    h.delete_if { |key, value| value < @param_count }

    h.select do |key|
      temp_key_array << key
    end

    temp_key_array.each do |id|
      filtered_resources << Resource.find(id)
    end

    # logger.debug "HOW MANY SHOULD BE SHOWN: #{repeats}"

    # logger.debug "DUPLICATES: #{h}"
    # logger.debug "RESOURCES: #{temp_key_array}"

    if params[:limit].present?
      limit = params[:limit].to_i
      if params[:offset].present?
        offset = params[:offset].to_i
        filtered_resources_with_limit_and_offset = filtered_resources[offset, limit]
        return filtered_resources_with_limit_and_offset
      else
        filtered_resources_with_limit = filtered_resources.take(limit)
        return filtered_resources_with_limit
      end
    else
      return filtered_resources
    end
  end


  def get_all_resources
    return Resource.all
  end

  def filters_are_set
    if params.except(:filter, :action, :format, :controller).present?
      return true
    end
  end

  def get_resources_by_user
    # return resources if param value is a number less than total amount of users
    if params[:user].to_i <= User.all.count && params[:user].to_i != 0
      return User.find(params[:user]).resources
    else
      return Resource.none
    end
  end

  def get_resources_by_licence
    # return resources if param value is a number less than total amount of licences
    if params[:licence].to_i <= Licence.all.count && params[:licence].to_i != 0
      return Licence.find(params[:licence]).resources
    elsif !params[:licence].match(/^[0-9]+$/i)
      Licence.where("lower(licence_type) = ?", params[:licence].downcase).find_each do |licence|
        return licence.resources
      end
    else
      return Resource.none
    end
  end

  def get_resources_by_tag
    # return resources by tag_id if param value is a number less than total amount of tags
    if params[:tag].to_i <= Tag.all.count && params[:tag].to_i != 0
      return Tag.find(params[:tag]).resources
    # return resources by tag_name
    # TODO: check if string is not numbers...
    elsif !params[:tag].match(/^[0-9]+$/i)
      Tag.where("lower(tag_name) = ?", params[:tag].downcase).find_each do |tag|
        return tag.resources
      end
    else
      return Resource.none
    end
  end

end
