RSpec.describe FocusActor::Future do
  describe 'User include Future' do
    it 'calls future method without blocking' do
      user = User.new('Fly')
      start_at = Time.now.to_f
      CASE_TIMES.times { user.future.grow(COST_TIME) }
      delta = Time.now.to_f - start_at
      expect(delta).to be < CASE_TIMES * COST_TIME
    end

    it 'calls future method return future' do
      user = User.new('Fly')
      futures = []
      total_cost = 0
      CASE_TIMES.times do
        cost = rand / 10
        total_cost += cost
        futures << user.future.grow(cost)
      end

      # waiting for futures down
      sleep total_cost + 0.1

      expect(futures.map(&:value).sort).to eq (1..5).to_a

      # Check for: No live threads left
      expect(futures.first.value).to be_truthy
    end
  end
end
