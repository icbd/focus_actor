RSpec.describe FocusActor::Async do
  describe 'User include Async' do
    it 'async calls method without blocking' do
      user = User.new('Bob')
      start_at = Time.now.to_f
      CASE_TIMES.times { user.async.grow(COST_TIME) }
      delta = Time.now.to_f - start_at
      expect(delta).to be < CASE_TIMES * COST_TIME
    end

    it 'async calls method' do
      user = User.new('Bob')
      CASE_TIMES.times do
        origin_age = user.age
        user.async.grow(COST_TIME)
        expect(user.age).to eq origin_age

        sleep COST_TIME + 0.1
        expect(user.age).to eq origin_age + 1
      end
    end
  end
end
