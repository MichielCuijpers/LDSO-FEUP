"""empty message

Revision ID: e44510af0f40
Revises: 53aa789ae0bd
Create Date: 2016-11-13 03:09:41.653869

"""

# revision identifiers, used by Alembic.
revision = 'e44510af0f40'
down_revision = '53aa789ae0bd'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('politician_proposal')
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.create_table('politician_proposal',
    sa.Column('idPolitician', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('idProposal', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['idPolitician'], [u'politics.idPolitician'], name=u'politician_proposal_idPolitician_fkey', onupdate=u'CASCADE', ondelete=u'CASCADE'),
    sa.ForeignKeyConstraint(['idProposal'], [u'proposals.idProposal'], name=u'politician_proposal_idProposal_fkey', onupdate=u'CASCADE'),
    sa.PrimaryKeyConstraint('idPolitician', 'idProposal', name=u'politician_proposal_pkey')
    )
    ### end Alembic commands ###